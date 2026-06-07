package com.whitestork.biometric.subscription.application.usecase;

import com.whitestork.biometric.shared.application.annotation.UseCase;
import com.whitestork.biometric.subscription.application.component.SubscriptionProvider;
import com.whitestork.biometric.subscription.application.response.SubscriptionPageResponse;
import com.whitestork.biometric.subscription.domain.Plan;
import com.whitestork.biometric.subscription.domain.Subscription;
import com.whitestork.biometric.user.domain.User;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class GetSubscriptionPageUseCase {

  private final SubscriptionProvider provider;

  public @NonNull SubscriptionPageResponse execute(@NonNull User user) {
    Plan plan = provider.planWithId(1L);
    Optional<Subscription> active = provider.activeSubscriptionWithUserIdOptional(user.savedId());
    return new SubscriptionPageResponse(plan, active.orElse(null));
  }
}