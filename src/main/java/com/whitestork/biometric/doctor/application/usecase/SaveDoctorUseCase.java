package com.whitestork.biometric.doctor.application.usecase;

import com.whitestork.biometric.doctor.application.component.DoctorSaver;
import com.whitestork.biometric.doctor.application.component.DoctorValidator;
import com.whitestork.biometric.doctor.application.mapper.DoctorMapper;
import com.whitestork.biometric.doctor.application.request.SaveDoctorRequest;
import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import com.whitestork.biometric.doctor.domain.Doctor;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class SaveDoctorUseCase {
  private final DoctorValidator validator;
  private final DoctorMapper mapper;
  private final DoctorSaver saver;

  public @NonNull DoctorResponse execute(@NonNull SaveDoctorRequest request) {
    validator.uniqueName(request.name());
    Doctor newDoctor = mapper.toDomain(request);
    Doctor savedDoctor = saver.save(newDoctor);
    return mapper.toResponse(savedDoctor);
  }
}
