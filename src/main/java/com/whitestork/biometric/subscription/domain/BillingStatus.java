package com.whitestork.biometric.subscription.domain;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.Getter;
import lombok.RequiredArgsConstructor;
import lombok.experimental.Accessors;
import org.jspecify.annotations.NonNull;

@Getter
@RequiredArgsConstructor
@Accessors(fluent = true)
public enum BillingStatus {
  PENDING(10),
  SUCCESS(20),
  FAILED(30),
  REFUNDED(40);

  private final int id;

  public static @NonNull BillingStatus fromId(int id) {
    for (BillingStatus billingStatus : BillingStatus.values()) {
      if (billingStatus.id == id)
        return billingStatus;
    }

    throw new DomainException("Статус счета подписки с ID \"%s\" не найден".formatted(id));
  }
}
