package com.whitestork.biometric.shared.application.component;

import com.whitestork.biometric.user.domain.User;
import com.whitestork.biometric.user.domain.UserRole;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

@Component("auth")
public class SecurityService {
  public boolean isAdmin(Authentication auth) {
    return auth.getPrincipal() instanceof User user && user.role() == UserRole.ADMIN;
  }

  public boolean isModerator(Authentication auth) {
    return auth.getPrincipal() instanceof User user && user.role() == UserRole.MODERATOR;
  }

  public boolean isUser(Authentication auth) {
    return auth.getPrincipal() instanceof User user  && user.role() == UserRole.USER;
  }
}