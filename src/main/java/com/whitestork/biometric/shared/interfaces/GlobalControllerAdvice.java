package com.whitestork.biometric.shared.interfaces;

import com.whitestork.biometric.user.infrastructure.security.SecurityUser;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalControllerAdvice {

  @ModelAttribute("authenticated")
  public boolean isAuthenticated(@AuthenticationPrincipal SecurityUser securityUser) {
    return securityUser != null;
  }
}
