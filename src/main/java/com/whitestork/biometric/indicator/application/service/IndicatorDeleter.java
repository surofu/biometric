package com.whitestork.biometric.indicator.application.service;

import com.whitestork.biometric.indicator.domain.Indicator;
import com.whitestork.biometric.indicator.infrastructure.persistence.IndicatorRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class IndicatorDeleter {
  private final IndicatorRepository repository;

  @Transactional
  public void delete(@NonNull Indicator indicator) {
    repository.delete(indicator);
  }
}
