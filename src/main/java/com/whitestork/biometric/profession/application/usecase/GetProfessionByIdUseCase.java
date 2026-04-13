package com.whitestork.biometric.profession.application.usecase;

import com.whitestork.biometric.doctor.application.mapper.DoctorMapper;
import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import com.whitestork.biometric.doctor.domain.Doctor;
import com.whitestork.biometric.doctor.infrastructure.persistence.DoctorRepository;
import com.whitestork.biometric.profession.application.component.ProfessionProvider;
import com.whitestork.biometric.profession.application.mapper.ProfessionMapper;
import com.whitestork.biometric.profession.application.response.ProfessionDetailsResponse;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class GetProfessionByIdUseCase {
  private final DoctorRepository doctorRepository;
  private final DoctorMapper doctorMapper;
  private final ProfessionProvider provider;
  private final ProfessionMapper mapper;

  public @NonNull ProfessionDetailsResponse execute(@NonNull Long id) {
    List<Doctor> doctors = doctorRepository.findAllByProfessionId(id);
    List<DoctorResponse> doctorResponses = doctors.stream()
        .map(doctorMapper::toResponse)
        .toList();
    return mapper.toDetailsResponse(provider.withId(id), doctorResponses);
  }
}
