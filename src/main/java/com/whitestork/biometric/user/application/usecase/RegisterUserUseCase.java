package com.whitestork.biometric.user.application.usecase;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.application.component.UserSaver;
import com.whitestork.biometric.user.application.component.UserValidator;
import com.whitestork.biometric.user.application.request.RegisterUserRequest;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class RegisterUserUseCase {
  private final UserValidator validator;
  private final PasswordEncoder passwordEncoder;
  private final UserSaver saver;
  private final SendVerificationEmailUseCase sendVerificationEmailUseCase;

  public void execute(@NonNull RegisterUserRequest request) {
    validator.uniqueEmail(request.email());
    User user = User.defaultUser(
        request.email(),
        encodedPassword(request.password()),
        request.agreement()
    ).withEmailVerified(true);
    User savedUser = saver.save(user);
//    sendVerificationEmailUseCase.execute(savedUser);
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
