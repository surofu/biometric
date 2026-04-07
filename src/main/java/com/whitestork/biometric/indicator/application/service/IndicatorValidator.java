package com.whitestork.biometric.indicator.application.service;

import com.whitestork.biometric.indicator.infrastructure.persistence.IndicatorRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class IndicatorValidator {
  private final IndicatorRepository repository;

  public void uniqueName(@NonNull String name) {
    if (repository.existsByName(name)) {
      throw new DomainException("Индикатор \"%s\" уже существует".formatted(name));
    }
  }
}
