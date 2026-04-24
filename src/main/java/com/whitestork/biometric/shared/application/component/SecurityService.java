package com.whitestork.biometric.shared.application.component;

import com.whitestork.biometric.user.domain.User;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;

@Component("auth")
public class SecurityService {

  public boolean isUser(Authentication auth) {
    return auth.getPrincipal() instanceof User user  && user.isUser();
  }

  public boolean isModerator(Authentication auth) {
    return auth.getPrincipal() instanceof User user && user.isModerator();
  }

  public boolean isAdmin(Authentication auth) {
    return auth.getPrincipal() instanceof User user && user.isAdmin();
  }
}