package com.whitestork.biometric.measurement.interfaces.model;

import java.time.LocalDate;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.With;
import org.jspecify.annotations.NonNull;

@With
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class SaveOrUpdateMeasurementModel {
  private Long id;
  private String userEmail;
  private Long indicatorId;
  private Double value;
  private LocalDate date = LocalDate.now();
}
