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
@Table("billing_history")
public record BillingHistory(
    @Id
    @Nullable Long id,
    @NonNull Long userId,
    @NonNull Long subscriptionId,
    @NonNull Long paymentMethodId,
    @NonNull BigDecimal amount,
    @NonNull String currency,
    @Column("status")
    @NonNull Integer statusId,
    @Nullable String gatewayTxId,
    @Nullable String failureReason,
    @CreatedDate
    @Nullable OffsetDateTime createdAt
) {

  public BillingHistory(
      @NonNull User user,
      @NonNull Subscription subscription,
      @NonNull PaymentMethod paymentMethod,
      @Nullable String gatewayTxId,
      @Nullable String failureReason
  ) {
    this(
        null,
        user.savedId(),
        subscription.savedId(),
        paymentMethod.savedId(),
        subscription.priceAtPurchase(),
        subscription.currency(),
        BillingStatus.PENDING.id(),
        gatewayTxId,
        failureReason,
        null
    );
  }

  public @NonNull Long savedId() {
    if (id == null) {
      log.error("История счетов без ID");
      throw new DomainException("Что-то пошло не так");
    }
    return id;
  }

  public @NonNull BillingStatus status() {
    return BillingStatus.fromId(statusId);
  }

  public @NonNull BillingHistory withStatus(@NonNull BillingStatus status) {
    return withStatusId(status.id());
  }
}