package com.whitestork.biometric.subscription.domain;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import java.math.BigDecimal;
import java.time.OffsetDateTime;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.LastModifiedDate;
import org.springframework.data.relational.core.mapping.Table;

@Slf4j
@Table("subscription_plans")
public record Plan(
    @Id
    @Nullable Long id,
    @NonNull String name,
    @NonNull String description,
    @NonNull BigDecimal price,
    @NonNull String currency,
    @NonNull Integer durationMonths,
    @NonNull Boolean isActive,
    @CreatedDate
    @Nullable OffsetDateTime createdAt,
    @LastModifiedDate
    @Nullable OffsetDateTime updatedAt
) {

  public Plan(
      @NonNull String name,
      @NonNull String description,
      @NonNull BigDecimal price,
      @NonNull String currency,
      @NonNull Integer durationMonths,
      @NonNull Boolean isActive
  ) {
    this(
        null,
        name,
        description,
        price,
        currency,
        durationMonths,
        isActive,
        null,
        null
    );
  }

  public @NonNull Long savedId() {
    if (id == null) {
      log.error("План подписки без ID");
      throw new DomainException("Что-то пошло не так");
    }

    return id;
  }
}
