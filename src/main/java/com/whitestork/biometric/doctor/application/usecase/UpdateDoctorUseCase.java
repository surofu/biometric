package com.whitestork.biometric.doctor.application.usecase;

import com.whitestork.biometric.doctor.application.component.DoctorProvider;
import com.whitestork.biometric.doctor.application.component.DoctorSaver;
import com.whitestork.biometric.doctor.application.component.DoctorValidator;
import com.whitestork.biometric.doctor.application.mapper.DoctorMapper;
import com.whitestork.biometric.doctor.application.request.UpdateDoctorRequest;
import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import com.whitestork.biometric.doctor.domain.Doctor;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class UpdateDoctorUseCase {
  private final DoctorProvider provider;
  private final DoctorValidator validator;
  private final DoctorMapper mapper;
  private final DoctorSaver saver;

  public @NonNull DoctorResponse execute(@NonNull UpdateDoctorRequest request) {
    Doctor oldDoctor = provider.withId(request.id());

    if (!Objects.equals(oldDoctor.name(), request.name())) {
      validator.uniqueName(request.name());
    }

    Doctor updatedDoctor = mapper.toDomain(request);
    Doctor savedDoctor = saver.save(updatedDoctor);
    return mapper.toResponse(savedDoctor);
  }
}
