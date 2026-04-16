package com.whitestork.biometric.indicator.application.service;

import com.whitestork.biometric.indicator.domain.Indicator;
import com.whitestork.biometric.indicator.infrastructure.persistence.IndicatorRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class IndicatorSaver {
  private final IndicatorRepository repository;

  @Transactional
  public void save(@NonNull Indicator indicator) {
    repository.save(indicator);
  }
}
