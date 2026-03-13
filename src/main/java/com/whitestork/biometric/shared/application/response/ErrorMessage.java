package com.whitestork.biometric.shared.application.response;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import java.io.Serial;
import java.io.Serializable;
import org.jspecify.annotations.NonNull;

public record ErrorMessage(
    @NonNull String message,
    @NonNull String timestamp
) implements Serializable {
  @Serial
  private static final long serialVersionUID = 1L;

  public static @NonNull ErrorMessage from(@NonNull DomainException exception) {
    return new ErrorMessage(
        exception.getMessage(),
        java.time.Instant.now().toString()
    );
  }
}
