package com.whitestork.biometric.professiondoctor.application.component;

import com.whitestork.biometric.professiondoctor.domain.ProfessionDoctor;
import com.whitestork.biometric.professiondoctor.infrastructure.ProfessionDoctorRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ProfessionDoctorDeleter {
  private final ProfessionDoctorRepository repository;

  public void delete(@NonNull ProfessionDoctor professionDoctor) {
    repository.delete(professionDoctor);
  }
}
