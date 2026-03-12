package com.whitestork.biometric.user.interfaces.model;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;
import lombok.With;
import org.springframework.validation.annotation.Validated;

@With
public record ChangePasswordModel(
    @Validated
    @NotBlank(message = "Неверный старый пароль")
    @Size(min = 6, message = "Неверный старый пароль")
    String oldPassword,
    @Validated
    @NotBlank(message = "Новый пароль обязателен")
    @Size(min = 6, message = "Новый пароль должен содержать минимум 6 символов")
    String newPassword,
    @Validated
    @NotBlank(message = "Подтверждение нового пароля обязательно")
    String confirmNewPassword
) {
  public ChangePasswordModel() {
    this(null, null, null);
  }
}
