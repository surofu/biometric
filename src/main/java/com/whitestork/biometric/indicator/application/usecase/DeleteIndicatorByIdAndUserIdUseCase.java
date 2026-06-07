package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.component.IndicatorDeleter;
import com.whitestork.biometric.indicator.application.component.IndicatorProvider;
import com.whitestork.biometric.measurement.application.component.MeasurementDeleter;
import com.whitestork.biometric.measurement.infrastructure.persistence.MeasurementRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class DeleteIndicatorByIdAndUserIdUseCase {
  private final IndicatorProvider provider;
  private final IndicatorDeleter deleter;
  private final MeasurementRepository measurementRepository;

  @Transactional
  public void execute(@NonNull Long id, @NonNull Long userId) {
    measurementRepository.deleteByIndicatorIdAndUserId(id, userId);
    deleter.delete(provider.withIdAndUserId(id, userId));
  }
}
