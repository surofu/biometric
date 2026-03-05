package com.whitestork.biometric.measurement.application.service;

import com.whitestork.biometric.measurement.domain.Measurement;
import com.whitestork.biometric.measurement.infrastructure.persistence.MeasurementRepository;
import com.whitestork.biometric.shared.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class MeasurementProvider {
  private final MeasurementRepository repository;

  @NonNull
  public Measurement withId(@NonNull Long id) {
    return repository.findById(id)
        .orElseThrow(() -> new DomainException("Результат с ID %s не найден".formatted(id)));
  }

  public Measurement withIdAndUserEmail(@NonNull Long id, @NonNull String userEmail) {
    return repository.findByIdAndUserEmail(id, userEmail)
        .orElseThrow(() -> new DomainException("Результат с ID %s не найден".formatted(id)));
  }
}
