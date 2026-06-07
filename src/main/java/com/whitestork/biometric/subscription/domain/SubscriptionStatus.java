package com.whitestork.biometric.subscription.domain;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.Getter;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;
import lombok.experimental.Accessors;

@Getter@Accessors(fluent = true)
@RequiredArgsConstructor
public enum SubscriptionStatus {
  ACTIVE(10, "Активна"),
  EXPIRED(20, "Истекла"),
  CANCELED(30, "Отменена");

  private final int id;
  private final String label;

  public static @NonNull SubscriptionStatus fromId(int id) {
    for (SubscriptionStatus status : SubscriptionStatus.values()) {
      if (status.id == id) {
        return status;
      }
    }

    throw new DomainException("Статус подписки с ID \"%s\" не найден".formatted(id));
  }
}
