package com.whitestork.biometric.admin.interfaces;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Slf4j
@Controller
@RequestMapping("/admin")
@PreAuthorize("@auth.isModerator(authentication) or @auth.isAdmin(authentication)")
public class AdminController {

  @GetMapping
  public String dashboard(Authentication auth) {
    return "admin/dashboard";
  }
}
