package com.whitestork.biometric.user.infrastructure.security;

import com.whitestork.biometric.user.application.component.UserProvider;
import com.whitestork.biometric.user.domain.User;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Slf4j
@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {
  private final UserProvider provider;

  @Override
  public @NonNull UserDetails loadUserByUsername(
      @NonNull String email
  ) throws UsernameNotFoundException {
    try {
      User user = provider.withEmail(email);
      if (user.passwordHash().isEmpty()) {
        throw new DisabledException("google_account:" + email);
      }
      return user;
    } catch (Exception exception) {
      log.warn("Unable to load UserDetails for {}", email, exception);
      HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder
          .currentRequestAttributes())
          .getRequest();
      request.getSession().setAttribute("errorMessage", exception.getMessage());
      throw new UsernameNotFoundException(exception.getMessage());
    }
  }
}
