package com.whitestork.biometric.analytics.infrastructure.view;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import org.jspecify.annotations.NonNull;

public record MeasurementAnalyticsView(
    @NonNull Double value,
    @NonNull LocalDate date
) {

  public @NonNull String dayOfWeek() {
    return date.format(DateTimeFormatter.ofPattern("EEE", Locale.forLanguageTag("ru")));
  }
}
