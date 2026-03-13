package com.whitestork.biometric.measurement.application.service;

import com.whitestork.biometric.measurement.domain.Measurement;
import com.whitestork.biometric.measurement.infrastructure.persistence.MeasurementRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import java.util.function.Supplier;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class MeasurementProvider {
  private final MeasurementRepository repository;

  public @NonNull Measurement withId(@NonNull Long id) {
    return repository.findById(id).orElseThrow(exceptionHandler(id));
  }

  public @NonNull Measurement withIdAndUserEmail(@NonNull Long id, @NonNull String userEmail) {
    return repository.findByIdAndUserEmail(id, userEmail).orElseThrow(exceptionHandler(id));
  }

  private @NonNull Supplier<DomainException> exceptionHandler(@NonNull Long id) {
    return () -> new DomainException("Результат с ID %s не найден".formatted(id));
  }
}
