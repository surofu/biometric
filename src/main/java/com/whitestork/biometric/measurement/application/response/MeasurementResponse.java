package com.whitestork.biometric.measurement.application.response;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;

public record MeasurementResponse(
    Long id,
    Double value,
    LocalDate date,

    Long indicatorId,
    String indicatorName,
    String indicatorUnit,
    Double indicatorReferenceMin,
    Double indicatorReferenceMax
) {
  public String formattedDate() {
    return DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm").withZone(ZoneId.systemDefault())
        .format(date);
  }
}
