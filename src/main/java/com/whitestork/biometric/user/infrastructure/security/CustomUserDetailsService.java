package com.whitestork.biometric.user.infrastructure.security;

import com.whitestork.biometric.user.application.service.UserProvider;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
  private final UserProvider provider;

  @NonNull
  @Override
  public UserDetails loadUserByUsername(@NonNull String email) throws UsernameNotFoundException {
    try {
      User user = provider.withEmail(email);
      return new SecurityUser(user.email(), user.passwordHash());
    } catch (Exception exception) {
      throw new UsernameNotFoundException(exception.getMessage());
    }
  }
}
