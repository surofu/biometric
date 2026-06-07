package com.whitestork.biometric.subscription.application.component;

import com.whitestork.biometric.subscription.domain.BillingHistory;
import com.whitestork.biometric.subscription.domain.PaymentMethod;
import com.whitestork.biometric.subscription.domain.Subscription;
import com.whitestork.biometric.subscription.infrastructure.persistence.BillingHistoryRepository;
import com.whitestork.biometric.subscription.infrastructure.persistence.PaymentMethodRepository;
import com.whitestork.biometric.subscription.infrastructure.persistence.SubscriptionRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class SubscriptionSaver {

  private final PaymentMethodRepository paymentMethodRepository;
  private final SubscriptionRepository subscriptionRepository;
  private final BillingHistoryRepository billingHistoryRepository;

  public @NonNull PaymentMethod savePaymentMethod(@NonNull PaymentMethod paymentMethod) {
    return paymentMethodRepository.save(paymentMethod);
  }

  public @NonNull Subscription saveSubscription(@NonNull Subscription subscription) {
    return subscriptionRepository.save(subscription);
  }

  public @NonNull BillingHistory saveBillingHistory(@NonNull BillingHistory billingHistory) {
    return billingHistoryRepository.save(billingHistory);
  }
}