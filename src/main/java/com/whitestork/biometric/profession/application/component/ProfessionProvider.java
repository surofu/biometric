package com.whitestork.biometric.profession.application.component;

import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import com.whitestork.biometric.doctor.infrastructure.persistence.DoctorRepository;
import com.whitestork.biometric.profession.application.mapper.ProfessionMapper;
import com.whitestork.biometric.profession.application.response.ProfessionDetailsResponse;
import com.whitestork.biometric.profession.domain.Profession;
import com.whitestork.biometric.profession.infrastructrure.persistence.ProfessionRepository;
import com.whitestork.biometric.profession.infrastructrure.projection.ProfessionDetailsProjection;
import com.whitestork.biometric.shared.domain.exception.DomainException;
import java.util.List;
import java.util.function.Supplier;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class ProfessionProvider {
  private final ProfessionRepository repository;
  private final ProfessionMapper mapper;
  private final DoctorRepository doctorRepository;

  public @NonNull Profession withId(@NonNull Long id) {
    return repository.findById(id).orElseThrow(handleNotFound(id));
  }

  public @NonNull ProfessionDetailsResponse withIdDetailsResponse(@NonNull Long id) {
    ProfessionDetailsProjection projection = repository.findByIdDetailsResponse(id)
        .orElseThrow(handleNotFound(id));
    ProfessionDetailsResponse response = mapper.toDetailsResponse(projection);
    List<DoctorResponse> doctors = doctorRepository.findAllResponsesByProfessionId(id);
    response.setDoctors(doctors);
    return response;
  }

  private @NonNull Supplier<DomainException> handleNotFound(@NonNull Long id) {
    return () -> new DomainException("Профессия с ID \"%s\" не найдена".formatted(id));
  }
}
