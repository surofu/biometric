package com.whitestork.biometric.measurement.application.usecase;

import com.whitestork.biometric.measurement.application.mapper.MeasurementMapper;
import com.whitestork.biometric.measurement.application.request.SaveMeasurementRequest;
import com.whitestork.biometric.measurement.application.request.SaveOrUpdateMeasurementRequest;
import com.whitestork.biometric.measurement.application.request.UpdateMeasurementRequest;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import com.whitestork.biometric.user.domain.User;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class SaveOrUpdateMeasurementUseCase {
  private final MeasurementMapper mapper;
  private final SaveMeasurementUseCase saveMeasurementUseCase;
  private final UpdateMeasurementUseCase updateMeasurementUseCase;

  public @NonNull MeasurementResponse execute(
      @NonNull SaveOrUpdateMeasurementRequest request,
      @NonNull User user
  ) {
    SaveOrUpdateMeasurementRequest requestWithUserEmail = request.withUserEmail(user.email());

    if (request.id() != null) {
      UpdateMeasurementRequest updateRequest = mapper.toUpdateRequest(requestWithUserEmail);
      return updateMeasurementUseCase.execute(updateRequest);
    }

    SaveMeasurementRequest saveRequest = mapper.toSaveRequest(requestWithUserEmail);
    return saveMeasurementUseCase.execute(saveRequest);
  }
}
