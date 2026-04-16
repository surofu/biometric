package com.whitestork.biometric.doctor.application.response;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class DoctorDetailsResponse {
  private Long id;
  private String name;
  private String description;
}
