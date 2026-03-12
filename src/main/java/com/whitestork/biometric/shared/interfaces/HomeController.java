package com.whitestork.biometric.shared.interfaces;

import com.whitestork.biometric.user.infrastructure.security.SecurityUser;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class HomeController {

  @GetMapping("/")
  @PreAuthorize("permitAll()")
  public String homePage(@AuthenticationPrincipal SecurityUser securityUser, Model model) {
    return "index";
  }
}
