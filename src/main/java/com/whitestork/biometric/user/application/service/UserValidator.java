package com.whitestork.biometric.user.application.service;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.infrastructure.persistence.UserRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UserValidator {
  private final UserRepository repository;

  public void uniqueEmail(@NonNull String email) {
    if (repository.existsByEmail(email)) {
      throw new DomainException("Пользователь с почтой \"%s\" уже существует".formatted(email));
    }
  }
}
