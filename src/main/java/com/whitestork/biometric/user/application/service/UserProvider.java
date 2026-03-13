package com.whitestork.biometric.user.application.service;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.domain.User;
import com.whitestork.biometric.user.infrastructure.persistence.UserRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class UserProvider {
  private final UserRepository repository;

  public @NonNull User withId(@NonNull Long id) {
    return repository.findById(id)
        .orElseThrow(() -> new DomainException("Пользователь с ID %s не найден".formatted(id)));
  }

  public @NonNull User withEmail(@NonNull String email) {
    return repository.findByEmail(email)
        .orElseThrow(() -> new DomainException("Пользователь %s не найден".formatted(email)));
  }
}
