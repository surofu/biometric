package com.whitestork.biometric.shared.infrastructure.config;

import com.whitestork.biometric.user.domain.User;
import java.time.OffsetDateTime;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.auditing.DateTimeProvider;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jdbc.core.convert.JdbcCustomConversions;
import org.springframework.data.jdbc.repository.config.AbstractJdbcConfiguration;
import org.springframework.data.jdbc.repository.config.EnableJdbcAuditing;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

@Configuration
@RequiredArgsConstructor
@EnableJdbcAuditing(dateTimeProviderRef = "dateTimeProvider")
public class DataJdbcConfig extends AbstractJdbcConfiguration {
  private final List<Converter<?, ?>> converters;

  @Override
  public @NonNull JdbcCustomConversions jdbcCustomConversions() {
    return new JdbcCustomConversions(converters);
  }

  @Bean
  public @NonNull DateTimeProvider dateTimeProvider() {
    return () -> Optional.of(OffsetDateTime.now());
  }

  @Bean
  public AuditorAware<String> auditorProvider() {
    return () -> {
      Authentication authentication = SecurityContextHolder.getContext().getAuthentication();

      if (authentication == null || !authentication.isAuthenticated()) {
        return Optional.empty();
      }

      Object principal = authentication.getPrincipal();

      if (principal instanceof User user) {
        return Optional.of(user.getUsername());
      }

      if (principal instanceof String username) {
        return Optional.of(username);
      }

      return Optional.empty();
    };
  }
}
