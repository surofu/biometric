package com.whitestork.biometric.user.interfaces.model;

import lombok.With;

@With
public record RegisterUserModel(
    String email,
    String password,
    String confirmPassword
) {
  public RegisterUserModel() {
    this(null, null, null);
  }
}
