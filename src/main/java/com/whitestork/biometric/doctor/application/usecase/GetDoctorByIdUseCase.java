package com.whitestork.biometric.doctor.application.usecase;

import com.whitestork.biometric.doctor.application.component.DoctorProvider;
import com.whitestork.biometric.doctor.application.mapper.DoctorMapper;
import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class GetDoctorByIdUseCase {
  private final DoctorProvider provider;
  private final DoctorMapper mapper;

  public @NonNull DoctorResponse execute(@NonNull Long id) {
    return mapper.toResponse(provider.withId(id));
  }
}
