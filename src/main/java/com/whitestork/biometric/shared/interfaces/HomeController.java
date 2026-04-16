package com.whitestork.biometric.shared.interfaces;

import java.security.Principal;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
@RequiredArgsConstructor
public class HomeController {

  @GetMapping("/")
  @PreAuthorize("permitAll()")
  public @NonNull String homePage(Principal principal) {
    if (principal != null) {
      return "redirect:/reference";
    }

    return "index";
  }

  @GetMapping("/about")
  public String aboutPage() {
    return "about";
  }
}
