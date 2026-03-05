package com.whitestork.biometric.user.application.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import org.springframework.validation.annotation.Validated;

public record LoginRequest(
    @Validated
    @NotBlank
    @Email(regexp = "^[A-Za-z0-9+_.-]+@(.+)$", message = "Некорректный формат почты")
    String email,
    @Validated
    @NotBlank
    String password
) {
  public LoginRequest() {
    this(null, null);
  }
}
