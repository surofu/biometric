package com.whitestork.biometric.professiondoctor.application.component;

import com.whitestork.biometric.professiondoctor.domain.ProfessionDoctor;
import com.whitestork.biometric.professiondoctor.infrastructure.ProfessionDoctorRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

@Component
@RequiredArgsConstructor
public class ProfessionDoctorSaver {
  private final ProfessionDoctorRepository repository;

  @Transactional
  public void saveAll(@NonNull List<ProfessionDoctor> professionDoctors) {
    repository.saveAll(professionDoctors);
  }
}
