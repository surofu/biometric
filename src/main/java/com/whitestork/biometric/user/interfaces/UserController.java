package com.whitestork.biometric.user.interfaces;

import com.whitestork.biometric.user.infrastructure.security.SecurityUser;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequiredArgsConstructor
public class UserController {

  @GetMapping("/profile")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String profilePage(
      @Nullable @RequestParam(required = false) String passwordChanged,
      @NonNull @AuthenticationPrincipal SecurityUser securityUser,
      @NonNull Model model
  ) {
    model.addAttribute("email", securityUser.email());

    if (passwordChanged != null) {
      model.addAttribute("successMessage", "Пароль успешно изменён");
    }

    return "user/profile";
  }
}
