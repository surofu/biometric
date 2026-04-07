package com.whitestork.biometric.measurement.interfaces.model;

import java.time.LocalDate;
import lombok.With;

@With
public record SaveOrUpdateMeasurementModel(
    Long id,
    String userEmail,
    Long indicatorId,
    Double value,
    LocalDate date
) {

  public SaveOrUpdateMeasurementModel() {
    this(null, null, null, null, LocalDate.now());
  }
}
