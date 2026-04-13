package com.whitestork.biometric.doctor.application.usecase;

import com.whitestork.biometric.doctor.application.component.DoctorDeleter;
import com.whitestork.biometric.doctor.application.component.DoctorProvider;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class DeleteDoctorUseCase {
  private final DoctorProvider provider;
  private final DoctorDeleter deleter;

  public void execute(@NonNull Long id) {
    deleter.delete(provider.withId(id));
  }
}
