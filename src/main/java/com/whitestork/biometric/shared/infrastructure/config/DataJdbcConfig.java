package com.whitestork.biometric.shared.infrastructure.config;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.domain.AuditorAware;
import org.springframework.data.jdbc.core.convert.JdbcCustomConversions;
import org.springframework.data.jdbc.repository.config.AbstractJdbcConfiguration;
import org.springframework.data.jdbc.repository.config.EnableJdbcAuditing;

@Configuration
@EnableJdbcAuditing
@RequiredArgsConstructor
public class DataJdbcConfig extends AbstractJdbcConfiguration {
  private final List<Converter<?, ?>> converters;

  @Bean
  @Override
  public @NonNull JdbcCustomConversions jdbcCustomConversions() {
    return new JdbcCustomConversions(converters);
  }

  @Bean
  public AuditorAware<LocalDateTime> auditorProvider() {
    return () -> Optional.of(LocalDateTime.now());
  }
}
