package com.whitestork.biometric.measurement.application.request;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import lombok.With;

@With
public record SaveOrUpdateMeasurementRequest(
    Long id,
    String userEmail,
    Long indicatorId,
    Double value,
    LocalDate date
) {

  public SaveOrUpdateMeasurementRequest() {
    this(null, null, null, null, LocalDate.now());
  }

  public String formattedDate() {
    if (date == null) {
      return "";
    }

    return DateTimeFormatter.ofPattern("yyyy-MM-dd")
        .withZone(ZoneId.systemDefault())
        .format(date);
  }
}
