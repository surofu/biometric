package com.whitestork.biometric.user.infrastructure.persistence;

import com.whitestork.biometric.user.domain.EmailVerificationToken;
import java.util.Optional;
import org.jspecify.annotations.NonNull;
import org.springframework.data.repository.ListCrudRepository;

public interface EmailVerificationTokenRepository extends
    ListCrudRepository<EmailVerificationToken, Long> {

  @NonNull Optional<EmailVerificationToken> findByToken(@NonNull String token);

  void deleteByUserId(@NonNull Long userId);
}