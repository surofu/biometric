package com.whitestork.biometric.measurement.application.usecase;

import com.whitestork.biometric.measurement.application.mapper.MeasurementMapper;
import com.whitestork.biometric.measurement.application.request.SaveMeasurementRequest;
import com.whitestork.biometric.measurement.application.request.SaveOrUpdateMeasurementRequest;
import com.whitestork.biometric.measurement.application.request.UpdateMeasurementRequest;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SaveOrUpdateMeasurementUseCase {
  private final MeasurementMapper mapper;
  private final SaveMeasurementUseCase saveMeasurementUseCase;
  private final UpdateMeasurementUseCase updateMeasurementUseCase;

  public void execute(@NonNull SaveOrUpdateMeasurementRequest request) {
    if (request.id() == null) {
      SaveMeasurementRequest saveRequest = mapper.toSaveMeasurementRequest(request);
      saveMeasurementUseCase.execute(saveRequest);
      return;
    }

    UpdateMeasurementRequest updateRequest = mapper.toUpdateMeasurementRequest(request);
    updateMeasurementUseCase.execute(updateRequest);
  }
}
