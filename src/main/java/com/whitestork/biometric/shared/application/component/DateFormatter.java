package com.whitestork.biometric.shared.application.component;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import org.springframework.stereotype.Component;

@Component
public class DateFormatter {
  private static final DateTimeFormatter DEFAULT_FORMAT =
      DateTimeFormatter.ofPattern("dd.MM.yyyy", Locale.forLanguageTag("ru"));
  private static final DateTimeFormatter DAY_OF_WEEK_FORMAT =
      DateTimeFormatter.ofPattern("EEE", Locale.forLanguageTag("ru"));
  private static final DateTimeFormatter HTML_DATE_FORMAT =
      DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.forLanguageTag("ru"));
  private static final String EMPTY_DATE = "";

  public String format(LocalDate date) {
    if (date == null) {
      return EMPTY_DATE;
    }
    return date.format(DEFAULT_FORMAT);
  }

  public String dayOfWeek(LocalDate date) {
    if (date == null) {
      return EMPTY_DATE;
    }

    return date.format(DAY_OF_WEEK_FORMAT);
  }

  public String htmlInput(LocalDate date) {
    if (date == null) {
      return EMPTY_DATE;
    }

    return date.format(HTML_DATE_FORMAT);
  }
}