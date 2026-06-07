package com.whitestork.biometric.subscription.application.usecase;

import com.whitestork.biometric.shared.application.annotation.UseCase;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.subscription.application.component.SubscriptionProvider;
import com.whitestork.biometric.subscription.application.component.SubscriptionSaver;
import com.whitestork.biometric.subscription.application.component.SubscriptionValidator;
import com.whitestork.biometric.subscription.application.request.CreateSubscriptionRequest;
import com.whitestork.biometric.subscription.domain.BillingHistory;
import com.whitestork.biometric.subscription.domain.BillingStatus;
import com.whitestork.biometric.subscription.domain.PaymentMethod;
import com.whitestork.biometric.subscription.domain.Plan;
import com.whitestork.biometric.subscription.domain.Subscription;
import com.whitestork.biometric.subscription.infrastructure.payment.MockPaymentGateway;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@UseCase
@RequiredArgsConstructor
public class CreateSubscriptionUseCase {

  private final SubscriptionValidator validator;
  private final SubscriptionProvider provider;
  private final SubscriptionSaver saver;
  private final MockPaymentGateway paymentGateway;

  @Transactional
  public void execute(@NonNull User user, @NonNull CreateSubscriptionRequest request) {
    validator.hasActiveSubscription(user.savedId());

    Plan plan = provider.planWithId(request.planId());

    // Сохраняем способ оплаты
    String cardLast4 = request.cardNumber().substring(12);
    PaymentMethod paymentMethod = saver.savePaymentMethod(
        new PaymentMethod(user, "MOCK", "mock-token-" + cardLast4, cardLast4, "CARD",
            request.expiryDate())
    );

    // Создаём подписку (сначала сохраняем, чтобы получить ID для billing_history)
    Subscription subscription = saver.saveSubscription(
        new Subscription(user, plan, paymentMethod)
    );

    // Создаём запись в истории со статусом PENDING
    BillingHistory billing = saver.saveBillingHistory(
        new BillingHistory(user, subscription, paymentMethod, null, null)
    );

    // Имитируем оплату через шлюз
    MockPaymentGateway.PaymentResult result = paymentGateway.charge(request.cardNumber());

    if (result.success()) {
      saver.saveBillingHistory(
          billing.withStatus(BillingStatus.SUCCESS).withGatewayTxId(result.transactionId())
      );
      log.info("Подписка оформлена: userId={}, planId={}, txId={}", user.savedId(), plan.savedId(),
          result.transactionId());
    } else {
      saver.saveBillingHistory(
          billing.withStatus(BillingStatus.FAILED).withFailureReason(result.failureReason())
      );
      // Откатываем транзакцию — подписка не создаётся
      throw new DomainException(result.failureReason());
    }
  }
}