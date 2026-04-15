package com.whitestork.biometric.user.application.usecase;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.application.component.UserProvider;
import com.whitestork.biometric.user.application.component.UserSaver;
import com.whitestork.biometric.user.application.request.ChangePasswordRequest;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class ChangePasswordUseCase {
  private final UserProvider userProvider;
  private final UserSaver userSaver;
  private final PasswordEncoder passwordEncoder;

  public void execute(@NonNull ChangePasswordRequest request) {
    User user = userProvider.withEmail(request.email());

    if (!passwordEncoder.matches(request.oldPassword(), user.passwordHash())) {
      throw new DomainException("Неверный старый пароль");
    }

    userSaver.save(user.withPasswordHash(encodedPassword(request.newPassword())));
  }

  private @NonNull String encodedPassword(@NonNull String password) {
    String hash = passwordEncoder.encode(password);

    if (hash == null) {
      log.error("Пустой хэш пароля");
      throw new DomainException("Что-то пошло не так");
    }

    return hash;
  }
}
