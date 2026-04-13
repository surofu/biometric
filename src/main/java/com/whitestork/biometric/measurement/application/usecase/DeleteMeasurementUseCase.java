package com.whitestork.biometric.measurement.application.usecase;

import com.whitestork.biometric.measurement.application.component.MeasurementDeleter;
import com.whitestork.biometric.measurement.application.component.MeasurementProvider;
import com.whitestork.biometric.measurement.domain.Measurement;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DeleteMeasurementUseCase {
  private final MeasurementProvider provider;
  private final MeasurementDeleter deleter;

  public void execute(@NonNull Long id, @NonNull String userEmail) {
    Measurement measurement = provider.withIdAndUserEmail(id, userEmail);
    deleter.delete(measurement);
  }
}
