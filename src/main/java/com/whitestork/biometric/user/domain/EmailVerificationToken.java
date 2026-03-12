package com.whitestork.biometric.user.domain;

import java.time.Duration;
import java.time.Instant;
import lombok.With;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@With
@Table("email_verification_tokens")
public record EmailVerificationToken(
    @Id
    @Nullable
    Long id,
    @NonNull
    Long userId,
    @NonNull
    String token,
    @NonNull
    Instant expiresAt,
    @NonNull
    Boolean used
) {

  public EmailVerificationToken(
      @NonNull
      Long userId,
      @NonNull
      String token
  ) {
    this(null, userId, token, Instant.now().plus(Duration.ofHours(24)), false);
  }

  public boolean isExpired() {
    return Instant.now().isAfter(expiresAt);
  }
}
