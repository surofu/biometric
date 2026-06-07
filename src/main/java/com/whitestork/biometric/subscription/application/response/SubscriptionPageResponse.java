package com.whitestork.biometric.subscription.application.response;

import com.whitestork.biometric.subscription.domain.Plan;
import com.whitestork.biometric.subscription.domain.Subscription;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;

public record SubscriptionPageResponse(
    @NonNull Plan plan,
    @Nullable Subscription activeSubscription
) {
  public boolean hasActiveSubscription() {
    return activeSubscription != null;
  }
}