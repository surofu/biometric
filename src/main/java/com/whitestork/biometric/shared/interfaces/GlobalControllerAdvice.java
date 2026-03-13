package com.whitestork.biometric.shared.interfaces;

import com.whitestork.biometric.user.infrastructure.security.SecurityUser;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

  @ModelAttribute("authenticated")
  public @NonNull Boolean isAuthenticated(
      @Nullable @AuthenticationPrincipal SecurityUser securityUser
  ) {
    return securityUser != null;
  }
}
