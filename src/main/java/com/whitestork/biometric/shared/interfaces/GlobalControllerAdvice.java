package com.whitestork.biometric.shared.interfaces;

import com.whitestork.biometric.user.domain.User;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

  @ModelAttribute("authenticated")
  public @NonNull Boolean isAuthenticated(
      @Nullable @AuthenticationPrincipal User user
  ) {
    return user != null;
  }

  @ModelAttribute("authentication")
  public Authentication authentication() {
    return SecurityContextHolder.getContext().getAuthentication();
  }
}
