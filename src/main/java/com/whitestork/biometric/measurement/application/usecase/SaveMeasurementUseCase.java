package com.whitestork.biometric.measurement.application.usecase;

import com.whitestork.biometric.measurement.application.component.MeasurementSaver;
import com.whitestork.biometric.measurement.application.component.MeasurementValidator;
import com.whitestork.biometric.measurement.application.mapper.MeasurementMapper;
import com.whitestork.biometric.measurement.application.request.SaveMeasurementRequest;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.domain.Measurement;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import com.whitestork.biometric.user.application.component.UserProvider;
import com.whitestork.biometric.user.domain.User;
import java.time.Instant;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class SaveMeasurementUseCase {
  private final MeasurementValidator validator;
  private final UserProvider userProvider;
  private final MeasurementMapper mapper;
  private final MeasurementSaver saver;

  public @NonNull MeasurementResponse execute(@NonNull SaveMeasurementRequest request) {
    if (request.isUserIndicator()) {
      validator.uniqueWithUserIndicator(request.userEmail(), request.indicatorId(), request.date());
    } else {
      validator.unique(request.userEmail(), request.indicatorId(), request.date());
    }

    User user = userProvider.withEmail(request.userEmail());
    Measurement newMeasurement = mapper.toDomain(request)
        .withUserId(user.savedId())
        .withCreatedAt(Instant.now());
    Measurement saved = saver.save(newMeasurement);
    return mapper.toResponse(saved);
  }
}
