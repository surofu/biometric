package com.whitestork.biometric.user.interfaces.model;

import lombok.With;

@With
public record ChangePasswordModel(
    String oldPassword,
    String newPassword,
    String confirmNewPassword
) {
  public ChangePasswordModel() {
    this(null, null, null);
  }
}
