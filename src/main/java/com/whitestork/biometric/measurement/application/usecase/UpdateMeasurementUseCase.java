package com.whitestork.biometric.measurement.application.usecase;

import com.whitestork.biometric.measurement.application.mapper.MeasurementMapper;
import com.whitestork.biometric.measurement.application.request.UpdateMeasurementRequest;
import com.whitestork.biometric.measurement.application.service.MeasurementProvider;
import com.whitestork.biometric.measurement.application.service.MeasurementSaver;
import com.whitestork.biometric.measurement.domain.Measurement;
import java.time.Instant;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UpdateMeasurementUseCase {
  private final MeasurementProvider provider;
  private final MeasurementMapper mapper;
  private final MeasurementSaver saver;

  public void execute(@NonNull UpdateMeasurementRequest request) {
    Measurement oldMeasurement = provider.withId(request.id());
    Measurement updatedMeasurement = mapper.toDomain(request)
        .withId(oldMeasurement.id())
        .withUserId(oldMeasurement.userId())
        .withCreatedAt(Instant.now());
    saver.save(updatedMeasurement);
  }
}
