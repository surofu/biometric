package com.whitestork.biometric.measurement.application.response;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public record MeasurementGroupResponse(
    LocalDate date,
    Iterable<MeasurementResponse> items
) {

  public String dayOfWeek() {
    return date.format(DateTimeFormatter.ofPattern("EEE", Locale.forLanguageTag("ru")));
  }
}
