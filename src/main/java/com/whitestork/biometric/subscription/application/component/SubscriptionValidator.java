package com.whitestork.biometric.subscription.application.component;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.subscription.infrastructure.persistence.SubscriptionRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class SubscriptionValidator {
  private final SubscriptionRepository repository;

  public void hasActiveSubscription(@NonNull Long userId) {
    if (repository.findActiveByUserId(userId).isPresent()) {
      throw new DomainException("У вас уже есть активная подписка");
    }
  }
}
