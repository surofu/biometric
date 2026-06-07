package com.whitestork.biometric.subscription.domain;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.domain.User;
import java.math.BigDecimal;
import java.time.OffsetDateTime;
import lombok.With;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.CreatedDate;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Column;
import org.springframework.data.relational.core.mapping.Table;

@Slf4j
@With
@Table("user_subscriptions")
public record Subscription(
    @Id
    @Nullable Long id,
    @NonNull Long userId,
    @NonNull Long planId,
    @NonNull Long paymentMethodId,
    @Column("status")
    @NonNull Integer statusId,
    @NonNull BigDecimal priceAtPurchase,
    @NonNull String currency,
    @NonNull OffsetDateTime startDate,
    @NonNull OffsetDateTime endDate,
    @NonNull Boolean renew,
    @CreatedDate
    @Nullable OffsetDateTime createdAt
) {

  public Subscription(
      @NonNull User user,
      @NonNull Plan plan,
      @NonNull PaymentMethod paymentMethod
  ) {
    this(
        null,
        user.savedId(),
        plan.savedId(),
        paymentMethod.savedId(),
        SubscriptionStatus.ACTIVE.id(),
        plan.price(),
        plan.currency(),
        OffsetDateTime.now(),
        OffsetDateTime.now().plusMonths(plan.durationMonths()),
        true,
        null
    );
  }

  public @NonNull Long savedId() {
    if (id == null) {
      log.error("Подписка без ID");
      throw new DomainException("Что-то пошло не так");
    }
    return id;
  }

  public @NonNull SubscriptionStatus status() {
    return SubscriptionStatus.fromId(statusId);
  }

  public @NonNull Subscription withStatus(@NonNull SubscriptionStatus status) {
    return withStatusId(status.id());
  }

  public boolean isActive() {
    return status() == SubscriptionStatus.ACTIVE && endDate.isAfter(OffsetDateTime.now());
  }
}