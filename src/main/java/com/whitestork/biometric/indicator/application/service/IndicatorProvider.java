package com.whitestork.biometric.indicator.application.service;

import com.whitestork.biometric.indicator.domain.Indicator;
import com.whitestork.biometric.indicator.infrastructure.persistence.IndicatorRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class IndicatorProvider {
  private final IndicatorRepository repository;

  public @NonNull Indicator withId(@NonNull Long id) {
    return repository.findById(id)
        .orElseThrow(() -> new DomainException("Показатель с ID %s не найден".formatted(id)));
  }
}
