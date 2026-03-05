package com.whitestork.biometric.user.interfaces;

import com.whitestork.biometric.user.infrastructure.security.SecurityUser;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class UserController {

  @GetMapping("/profile")
  @PreAuthorize("isAuthenticated()")
  public String profilePage(@AuthenticationPrincipal SecurityUser securityUser, Model model) {
    model.addAttribute("email", securityUser.email());
    return "user/profile";
  }
}
