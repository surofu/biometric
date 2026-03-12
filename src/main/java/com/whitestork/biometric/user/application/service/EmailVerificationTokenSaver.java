package com.whitestork.biometric.user.application.service;

import com.whitestork.biometric.user.domain.EmailVerificationToken;
import com.whitestork.biometric.user.infrastructure.persistence.EmailVerificationTokenRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class EmailVerificationTokenSaver {
  private final EmailVerificationTokenRepository repository;

  @NonNull
  @Transactional
  public EmailVerificationToken save(@NonNull EmailVerificationToken token) {
    return repository.save(token);
  }
}
