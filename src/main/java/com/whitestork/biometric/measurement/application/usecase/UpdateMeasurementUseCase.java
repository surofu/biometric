package com.whitestork.biometric.measurement.application.usecase;

import com.whitestork.biometric.indicator.application.service.IndicatorProvider;
import com.whitestork.biometric.indicator.domain.Indicator;
import com.whitestork.biometric.measurement.application.mapper.MeasurementMapper;
import com.whitestork.biometric.measurement.application.request.UpdateMeasurementRequest;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
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
  private final IndicatorProvider indicatorProvider;

  @NonNull
  public MeasurementResponse execute(@NonNull UpdateMeasurementRequest request) {
    Measurement oldMeasurement = provider.withId(request.id());
    Measurement updatedMeasurement = mapper.toDomain(request)
        .withId(oldMeasurement.id())
        .withUserId(oldMeasurement.userId())
        .withCreatedAt(Instant.now());
    Measurement savedMeasurement = saver.save(updatedMeasurement);
    Indicator indicator = indicatorProvider.withId(savedMeasurement.indicatorId());
    return mapper.toResponse(savedMeasurement, indicator);
  }
}
