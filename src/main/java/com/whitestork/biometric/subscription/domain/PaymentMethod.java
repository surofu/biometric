package com.whitestork.biometric.subscription.domain;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.domain.User;
import java.time.OffsetDateTime;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@Slf4j
@Table("user_payment_methods")
public record PaymentMethod(
    @Id
    @Nullable Long id,
    @NonNull Long userId,
    @NonNull String provider,
    @NonNull String gatewayToken,
    @Nullable String cardLast4,
    @Nullable String cardType,
    @Nullable String expiryDate, // MM/YYYY
    @NonNull Boolean isDefault,
    @NonNull Boolean isActive,
    @CreatedDate
    @Nullable OffsetDateTime createdAt
) {

  public PaymentMethod(
      @NonNull User user,
      @NonNull String provider,
      @NonNull String gatewayToken,
      @Nullable String cardLast4,
      @Nullable String cardType,
      @Nullable String expiryDate
  ) {
    this(
        null,
        user.savedId(),
        provider,
        gatewayToken,
        cardLast4,
        cardType,
        expiryDate,
        true,
        true,
        null
    );
  }

  public @NonNull Long savedId() {
    if (id == null) {
      log.error("Способ оплаты без ID");
      throw new DomainException("Что-то пошло не так");
    }

    return id;
  }
}
