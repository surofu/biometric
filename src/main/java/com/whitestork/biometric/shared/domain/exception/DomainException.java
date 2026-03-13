package com.whitestork.biometric.shared.domain.exception;

import org.jspecify.annotations.NonNull;

public final class DomainException extends RuntimeException {
  public DomainException(@NonNull String message) {
    super(message);
  }

  public DomainException(@NonNull String message, @NonNull Throwable cause) {
    super(message, cause);
  }
}
