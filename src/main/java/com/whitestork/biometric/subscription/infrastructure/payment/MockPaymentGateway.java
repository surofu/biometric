package com.whitestork.biometric.subscription.infrastructure.payment;

import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

/**
 * Тестовая реализация платёжного шлюза.
 * Оплата проходит успешно, если все цифры номера карты одинаковы (например, 1111111111111111).
 * В реальном проекте заменяется на интеграцию с провайдером (Stripe, CloudPayments и т.д.).
 */
@Slf4j
@Component
public class MockPaymentGateway {

  public record PaymentResult(boolean success, String transactionId, String failureReason) {

    public static PaymentResult success(@NonNull String transactionId) {
      return new PaymentResult(true, transactionId, null);
    }

    public static PaymentResult failure(@NonNull String reason) {
      return new PaymentResult(false, null, reason);
    }
  }

  public @NonNull PaymentResult charge(@NonNull String cardNumber) {
    log.info("MockPaymentGateway: попытка списания по карте ****{}", cardNumber.substring(12));

    if (isTestSuccessCard(cardNumber)) {
      String txId = "MOCK-TX-" + System.currentTimeMillis();
      log.info("MockPaymentGateway: оплата успешна, txId={}", txId);
      return PaymentResult.success(txId);
    }

    log.info("MockPaymentGateway: оплата отклонена");
    return PaymentResult.failure("Карта отклонена. Проверьте данные.");
  }

  /**
   * Карта считается тестовой успешной, если все 16 цифр одинаковы (1111...1111, 4444...4444 и т.д.)
   */
  private boolean isTestSuccessCard(@NonNull String cardNumber) {
    if (cardNumber.length() != 16) return false;
    char first = cardNumber.charAt(0);
    for (char c : cardNumber.toCharArray()) {
      if (c != first) return false;
    }
    return true;
  }
}