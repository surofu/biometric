package com.whitestork.biometric.doctor.application.usecase;

import com.whitestork.biometric.doctor.application.mapper.DoctorMapper;
import com.whitestork.biometric.doctor.application.request.SaveDoctorRequest;
import com.whitestork.biometric.doctor.application.request.SaveOrUpdateDoctorRequest;
import com.whitestork.biometric.doctor.application.request.UpdateDoctorRequest;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class SaveOrUpdateDoctorUseCase {
  private final DoctorMapper mapper;
  private final SaveDoctorUseCase saveDoctorUseCase;
  private final UpdateDoctorUseCase updateDoctorUseCase;

  public void execute(@NonNull SaveOrUpdateDoctorRequest request) {
    if (request.id() != null) {
      UpdateDoctorRequest updateRequest = mapper.toUpdateRequest(request);
      updateDoctorUseCase.execute(updateRequest);
      return;
    }

    SaveDoctorRequest saveRequest = mapper.toSaveRequest(request);
    saveDoctorUseCase.execute(saveRequest);
  }
}
