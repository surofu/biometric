package com.whitestork.biometric.user.application.service;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.domain.EmailVerificationToken;
import com.whitestork.biometric.user.infrastructure.persistence.EmailVerificationTokenRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class EmailVerificationTokenProvider {
  private final EmailVerificationTokenRepository repository;

  public @NonNull EmailVerificationToken withToken(@NonNull String token) {
    return repository.findByToken(token).orElseThrow(
        () -> new DomainException("Ссылка недействительна")
    );
  }
}
