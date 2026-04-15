package com.whitestork.biometric.measurement.application.response;

import java.time.LocalDate;
import java.util.List;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MeasurementGroupResponse {
  private LocalDate date;
  private List<MeasurementResponse> items;
}
