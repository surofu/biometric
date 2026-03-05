package com.whitestork.biometric.measurement.application.usecase;

import com.whitestork.biometric.indicator.application.service.IndicatorProvider;
import com.whitestork.biometric.indicator.domain.Indicator;
import com.whitestork.biometric.measurement.application.mapper.MeasurementMapper;
import com.whitestork.biometric.measurement.application.request.SaveMeasurementRequest;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.application.service.MeasurementSaver;
import com.whitestork.biometric.measurement.application.service.MeasurementValidator;
import com.whitestork.biometric.measurement.domain.Measurement;
import com.whitestork.biometric.user.application.service.UserProvider;
import com.whitestork.biometric.user.domain.User;
import java.time.Instant;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SaveMeasurementUseCase {
  private final MeasurementValidator validator;
  private final UserProvider userProvider;
  private final MeasurementMapper mapper;
  private final MeasurementSaver saver;
  private final IndicatorProvider indicatorProvider;

  @NonNull
  public MeasurementResponse execute(@NonNull SaveMeasurementRequest request) {
    validator.unique(request.userEmail(), request.indicatorId(), request.date());
    User user = userProvider.withEmail(request.userEmail());
    Objects.requireNonNull(user.id(), "ID пользователя обязательно");
    Measurement newMeasurement = mapper.toDomain(request)
        .withUserId(user.id())
        .withCreatedAt(Instant.now());
    Measurement savedMeasurement = saver.save(newMeasurement);
    Indicator indicator = indicatorProvider.withId(savedMeasurement.indicatorId());
    return mapper.toResponse(savedMeasurement, indicator);
  }
}
