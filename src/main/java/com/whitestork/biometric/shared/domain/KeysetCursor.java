package com.whitestork.biometric.shared.domain;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import java.time.LocalDate;
import java.util.Base64;
import org.jspecify.annotations.NonNull;

public record KeysetCursor(@NonNull LocalDate date, @NonNull Long id) {
  private static final String SEPARATOR = ":";

  @NonNull
  public static KeysetCursor fromString(@NonNull String original) {
    try {
      byte[] decoded = Base64.getUrlDecoder().decode(original);
      String raw = new String(decoded);
      String[] parts = raw.split(SEPARATOR, 2);
      LocalDate date = LocalDate.parse(parts[0]);
      Long id = Long.parseLong(parts[1]);
      return new KeysetCursor(date, id);
    } catch (Exception exception) {
      throw new DomainException(
          "Не удалось декодировать курсор пагинации: %s".formatted(exception.getMessage()),
          exception
      );
    }
  }

  @NonNull
  public String toString() {
    String raw = date + SEPARATOR + id;
    return Base64.getUrlEncoder().withoutPadding().encodeToString(raw.getBytes());
  }
}
