package com.whitestork.biometric.user.infrastructure.persistence;

import com.whitestork.biometric.user.domain.EmailVerificationToken;
import java.util.Optional;
import org.springframework.data.repository.ListCrudRepository;

public interface EmailVerificationTokenRepository extends
    ListCrudRepository<EmailVerificationToken, Long> {

  Optional<EmailVerificationToken> findByToken(String token);

  void deleteByUserId(Long userId);
}