package com.whitestork.biometric.shared.application.component;

import com.whitestork.biometric.subscription.application.component.SubscriptionProvider;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

@Component("auth")
@RequiredArgsConstructor
public class SecurityService {

  private final SubscriptionProvider subscriptionProvider;

  public boolean isUser(Authentication auth) {
    return auth.getPrincipal() instanceof User user && user.isUser();
  }

  public boolean isModerator(Authentication auth) {
    return auth.getPrincipal() instanceof User user && user.isModerator();
  }

  public boolean isAdmin(Authentication auth) {
    return auth.getPrincipal() instanceof User user && user.isAdmin();
  }

  /**
   * Проверяет наличие активной подписки у текущего пользователя.
   * Используется в @PreAuthorize("@auth.isPremium(authentication)") и в шаблонах.
   */
  public boolean isPremium(Authentication auth) {
    if (!(auth.getPrincipal() instanceof User user)) return false;
    return subscriptionProvider.hasActiveSubscriptionWithUserId(user.savedId());
  }
}