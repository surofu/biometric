package com.whitestork.biometric.measurement.application.service;

import com.whitestork.biometric.measurement.domain.Measurement;
import com.whitestork.biometric.measurement.infrastructure.persistence.MeasurementRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class MeasurementSaver {
  private final MeasurementRepository repository;

  @Transactional
  public void save(Measurement measurement) {
    repository.save(measurement);
  }
}
