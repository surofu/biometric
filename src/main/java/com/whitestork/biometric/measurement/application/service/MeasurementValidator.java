package com.whitestork.biometric.measurement.application.service;

import com.whitestork.biometric.measurement.infrastructure.persistence.MeasurementRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import java.time.LocalDate;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class MeasurementValidator {
  private final MeasurementRepository repository;

  public void unique(@NonNull String email, @NonNull Long indicatorId, @NonNull LocalDate date) {
    if (repository.existsByUserEmailAndIndicatorIdAndDate(email, indicatorId, date)) {
      throw new DomainException("Запись с таким показателем уже существует!");
    }
  }
}
