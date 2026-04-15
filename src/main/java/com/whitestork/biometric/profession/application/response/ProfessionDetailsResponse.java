package com.whitestork.biometric.profession.application.response;

import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class ProfessionDetailsResponse {
  private Long id;
  private String name;
  private List<DoctorResponse> doctors;
}
