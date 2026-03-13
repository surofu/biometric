package com.whitestork.biometric.user.infrastructure.security;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.application.service.UserProvider;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
  private final UserProvider provider;

  @Override
  public @NonNull UserDetails loadUserByUsername(@NonNull String email)
      throws UsernameNotFoundException {
    try {
      User user = provider.withEmail(email);
      if (user.passwordHash().isEmpty()) {
        throw new DisabledException("google_account:" + email);
      }
      return new SecurityUser(user);
    } catch (DomainException exception) {
      throw new UsernameNotFoundException(exception.getMessage());
    }
  }
}
