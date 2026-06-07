package com.whitestork.biometric.subscription.application.component;

import com.whitestork.biometric.subscription.domain.Subscription;
import com.whitestork.biometric.subscription.infrastructure.persistence.SubscriptionRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class SubscriptionDeleter {
  private final SubscriptionRepository repository;

  @Transactional
  public void delete(@NonNull Subscription subscription) {
    repository.delete(subscription);
  }
}
