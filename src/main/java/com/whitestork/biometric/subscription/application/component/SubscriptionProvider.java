package com.whitestork.biometric.subscription.application.component;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.subscription.domain.Plan;
import com.whitestork.biometric.subscription.domain.Subscription;
import com.whitestork.biometric.subscription.infrastructure.persistence.PlanRepository;
import com.whitestork.biometric.subscription.infrastructure.persistence.SubscriptionRepository;
import java.util.Optional;
import java.util.function.Supplier;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class SubscriptionProvider {
  private final SubscriptionRepository subscriptionRepository;
  private final PlanRepository planRepository;

  public @NonNull Optional<Subscription> activeSubscriptionWithUserIdOptional(@NonNull Long userId) {
    return subscriptionRepository.findActiveByUserId(userId);
  }

  public @NonNull Subscription activeSubscriptionWithUserId(@NonNull Long userId) {
    return activeSubscriptionWithUserIdOptional(userId).orElseThrow(handleSubscriptionNotFound());
  }

  public @NonNull Boolean hasActiveSubscriptionWithUserId(@NonNull Long userId) {
    return activeSubscriptionWithUserIdOptional(userId).isPresent();
  }

  // Plan

  public @NonNull Plan planWithId(@NonNull Long id) {
    return planRepository.findById(id).orElseThrow(handlePlanNotFound(id));
  }

  // Handler

  private @NonNull Supplier<DomainException> handleSubscriptionNotFound() {
    return () -> new DomainException("Подписка не найдена");
  }

  private @NonNull Supplier<DomainException> handlePlanNotFound(@NonNull Long id) {
    return () -> new DomainException("План \"%s\" не найден".formatted(id));
  }
}
