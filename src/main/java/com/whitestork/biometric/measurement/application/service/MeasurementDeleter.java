package com.whitestork.biometric.measurement.application.service;

import com.whitestork.biometric.measurement.domain.Measurement;
import com.whitestork.biometric.measurement.infrastructure.persistence.MeasurementRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class MeasurementDeleter {
  private final MeasurementRepository repository;

  @Transactional
  public void delete(@NonNull Measurement measurement) {
    repository.delete(measurement);
  }
}
