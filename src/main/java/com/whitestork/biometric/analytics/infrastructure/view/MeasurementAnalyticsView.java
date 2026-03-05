package com.whitestork.biometric.analytics.infrastructure.view;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;

public record MeasurementAnalyticsView(
    Double value,
    LocalDate date
) {

  public String dayOfWeek() {
    return date.format(DateTimeFormatter.ofPattern("EEE", Locale.forLanguageTag("ru")));
  }
}
