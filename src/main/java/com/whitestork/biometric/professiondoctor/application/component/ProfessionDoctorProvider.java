package com.whitestork.biometric.professiondoctor.application.component;

import com.whitestork.biometric.professiondoctor.domain.ProfessionDoctor;
import com.whitestork.biometric.professiondoctor.infrastructure.ProfessionDoctorRepository;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ProfessionDoctorProvider {
  private final ProfessionDoctorRepository repository;

  public @NonNull ProfessionDoctor withIdPair(@NonNull Long professionId, @NonNull Long doctorId) {
    return repository.findByProfessionIdAndDoctorId(professionId, doctorId)
        .orElseThrow(() -> new DomainException(
            "Доктор \"%s\" не найден в профессии \"%s\"".formatted(doctorId, professionId)
        ));
  }
}
