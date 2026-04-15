package com.whitestork.biometric.admin.interfaces.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SaveOrUpdateDoctorModel {
  private Long id;
  private String name;
}
