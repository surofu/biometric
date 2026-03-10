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

  @NonNull
  public User withEmail(@NonNull String email) {
    return repository.findByEmail(email)
        .orElseThrow(() -> new DomainException("Пользователь %s не найден".formatted(email)));
  }
}
