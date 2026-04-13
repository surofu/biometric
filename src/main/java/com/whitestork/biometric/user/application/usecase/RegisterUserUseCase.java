package com.whitestork.biometric.user.application.usecase;

import com.whitestork.biometric.user.application.request.RegisterUserRequest;
import com.whitestork.biometric.user.application.component.UserSaver;
import com.whitestork.biometric.user.application.component.UserValidator;
import com.whitestork.biometric.user.domain.User;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RegisterUserUseCase {
  private final UserValidator validator;
  private final PasswordEncoder passwordEncoder;
  private final UserSaver saver;
  private final SendVerificationEmailUseCase sendVerificationEmailUseCase;

  public void execute(@NonNull RegisterUserRequest request) {
    validator.uniqueEmail(request.email());
    String passwordHash = passwordEncoder.encode(request.password());
    Objects.requireNonNull(passwordHash, "Пароль обязателен");
    User user = User.defaultUser(request.email(), passwordHash).withEmailVerified(true);
    User savedUser = saver.save(user);
//    sendVerificationEmailUseCase.execute(savedUser);
  }
}
