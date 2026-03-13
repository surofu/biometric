package com.whitestork.biometric.measurement.interfaces.model;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import lombok.With;
import org.jspecify.annotations.NonNull;

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

  public @NonNull String formattedDate() {
    if (date == null) {
      return "";
    }

    return DateTimeFormatter.ofPattern("yyyy-MM-dd")
        .withZone(ZoneId.systemDefault())
        .format(date);
  }
}
