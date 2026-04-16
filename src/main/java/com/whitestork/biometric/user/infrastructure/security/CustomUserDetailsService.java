package com.whitestork.biometric.user.infrastructure.security;

import com.whitestork.biometric.user.application.component.UserProvider;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Slf4j
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
      return user;
    } catch (Exception exception) {
      log.warn("Unable to load UserDetails for {}", email, exception);
      throw new UsernameNotFoundException(exception.getMessage());
    }
  }
}
