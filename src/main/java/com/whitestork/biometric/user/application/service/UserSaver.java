package com.whitestork.biometric.user.application.service;

import com.whitestork.biometric.user.domain.User;
import com.whitestork.biometric.user.infrastructure.persistence.UserRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class UserSaver {
  private final UserRepository repository;

  @Transactional
  public @NonNull User save(@NonNull User user) {
    return repository.save(user);
  }
}
