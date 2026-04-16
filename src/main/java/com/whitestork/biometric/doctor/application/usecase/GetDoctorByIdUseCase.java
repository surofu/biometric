package com.whitestork.biometric.doctor.application.usecase;

import com.whitestork.biometric.doctor.application.component.DoctorProvider;
import com.whitestork.biometric.doctor.application.response.DoctorDetailsResponse;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class GetDoctorByIdUseCase {
  private final DoctorProvider provider;

  public @NonNull DoctorDetailsResponse execute(@NonNull Long id) {
    return provider.withIdDetails(id);
  }
}
