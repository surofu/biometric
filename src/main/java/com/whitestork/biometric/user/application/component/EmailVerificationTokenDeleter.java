package com.whitestork.biometric.user.application.component;

import com.whitestork.biometric.user.infrastructure.persistence.EmailVerificationTokenRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class EmailVerificationTokenDeleter {
  private final EmailVerificationTokenRepository repository;

  @Transactional
  public void deleteWithUserId(@NonNull Long userId) {
    repository.deleteByUserId(userId);
  }
}
