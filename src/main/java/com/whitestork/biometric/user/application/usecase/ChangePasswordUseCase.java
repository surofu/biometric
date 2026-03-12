package com.whitestork.biometric.user.application.usecase;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.application.request.ChangePasswordRequest;
import com.whitestork.biometric.user.application.service.UserProvider;
import com.whitestork.biometric.user.application.service.UserSaver;
import com.whitestork.biometric.user.domain.User;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ChangePasswordUseCase {
  private final UserProvider userProvider;
  private final UserSaver userSaver;
  private final PasswordEncoder passwordEncoder;

  public @NonNull User execute(@NonNull ChangePasswordRequest request) {
    User user = userProvider.withEmail(request.email());

    if (!passwordEncoder.matches(request.oldPassword(), user.passwordHash())) {
      throw new DomainException("Неверный старый пароль");
    }

    String newPasswordHash = passwordEncoder.encode(request.newPassword());
    Objects.requireNonNull(newPasswordHash, "Новый пароль обязателен");
    return userSaver.save(user.withPasswordHash(newPasswordHash));
  }
}
