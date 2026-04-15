package com.whitestork.biometric.user.interfaces.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ChangePasswordModel {
  private String oldPassword;
  private String newPassword;
  private String confirmNewPassword;
}
