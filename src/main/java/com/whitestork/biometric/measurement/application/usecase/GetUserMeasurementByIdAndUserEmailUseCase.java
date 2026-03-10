package com.whitestork.biometric.measurement.application.usecase;

import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.infrastructure.persistence.MeasurementRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetUserMeasurementByIdAndUserEmailUseCase {
  private final MeasurementRepository repository;

  @NonNull
  public MeasurementResponse execute(@NonNull Long id, @NonNull String email) {
    return repository.findResponseByIdAndUserEmail(id, email)
        .orElseThrow(() -> new DomainException("Результат с ID %s не найден".formatted(id)));
  }
}
