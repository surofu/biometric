package com.whitestork.biometric.measurement.application.response;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;
import org.jspecify.annotations.NonNull;

public record MeasurementGroupResponse(
    @NonNull LocalDate date,
    @NonNull List<MeasurementResponse> items
) {

  public @NonNull String dayOfWeek() {
    return date.format(DateTimeFormatter.ofPattern("EEE", Locale.forLanguageTag("ru")));
  }
}
