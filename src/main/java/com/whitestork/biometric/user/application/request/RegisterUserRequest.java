package com.whitestork.biometric.user.application.request;

import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.With;
import org.springframework.validation.annotation.Validated;

@With
public record RegisterUserRequest(
    @Validated
    @NotBlank(message = "Почта обязательна")
    @Email(regexp = "^[A-Za-z0-9+_.-]+@(.+)$", message = "Некорректный формат почты")
    String email,
    @Validated
    @NotBlank(message = "Пароль обязателен")
    @Size(min = 6, message = "Пароль должен содержать минимум 6 символов")
    String password,
    @Validated
    @NotBlank(message = "Подтверждение пароля обязательно")
    String confirmPassword
) {
  public RegisterUserRequest() {
    this(null, null, null);
  }
}
