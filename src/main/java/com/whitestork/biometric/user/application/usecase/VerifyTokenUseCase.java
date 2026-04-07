package com.whitestork.biometric.user.application.usecase;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.application.service.EmailVerificationTokenProvider;
import com.whitestork.biometric.user.application.service.EmailVerificationTokenSaver;
import com.whitestork.biometric.user.application.service.UserProvider;
import com.whitestork.biometric.user.application.service.UserSaver;
import com.whitestork.biometric.user.domain.EmailVerificationToken;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class VerifyTokenUseCase {
  private final EmailVerificationTokenProvider tokenProvider;
  private final EmailVerificationTokenSaver tokenSaver;
  private final UserProvider userProvider;
  private final UserSaver userSaver;

  public @NonNull String execute(@NonNull String token) {
    EmailVerificationToken verificationToken = tokenProvider.withToken(token);

    if (verificationToken.used()) {
      throw new DomainException("Ссылка уже была использована");
    }

    if (verificationToken.isExpired()) {
      throw new DomainException("Ссылка истекла. Запросите новое письмо");
    }

    User user = userProvider.withId(verificationToken.userId());
    User savedUser = userSaver.save(user.withEmailVerified(true));
    tokenSaver.save(verificationToken.withUsed(true));
    return savedUser.email();
  }
}
