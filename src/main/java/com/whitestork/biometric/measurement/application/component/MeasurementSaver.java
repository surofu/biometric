package com.whitestork.biometric.measurement.application.component;

import com.whitestork.biometric.measurement.domain.Measurement;
import com.whitestork.biometric.measurement.infrastructure.persistence.MeasurementRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class MeasurementSaver {
  private final MeasurementRepository repository;

  @Transactional
  public Measurement save(@NonNull Measurement measurement) {
    return repository.save(measurement);
  }
}
