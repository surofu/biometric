package com.whitestork.biometric.user.application.component;

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

  @Transactional
  public void save(@NonNull EmailVerificationToken token) {
    repository.save(token);
  }
}
