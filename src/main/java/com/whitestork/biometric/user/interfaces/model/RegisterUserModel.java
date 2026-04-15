package com.whitestork.biometric.user.interfaces.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class RegisterUserModel {
  private String email;
  private String password;
  private String confirmPassword;
}
