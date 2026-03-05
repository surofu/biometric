package com.whitestork.biometric.shared.application.response;

import com.whitestork.biometric.shared.exception.DomainException;
import java.io.Serial;
import java.io.Serializable;

public record ErrorMessage(
    String message,
    String timestamp
) implements Serializable {
  @Serial
  private static final long serialVersionUID = 1L;

  public static ErrorMessage from(DomainException ex) {
    return new ErrorMessage(
        ex.getMessage(),
        java.time.Instant.now().toString()
    );
  }
}
