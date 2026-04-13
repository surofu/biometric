package com.whitestork.biometric.doctor.application.component;

import com.whitestork.biometric.doctor.domain.Doctor;
import com.whitestork.biometric.doctor.infrastructure.persistence.DoctorRepository;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class DoctorDeleter {
  private final DoctorRepository repository;

  @Transactional
  public void delete(@NonNull Doctor doctor) {
    repository.delete(doctor);
  }
}
