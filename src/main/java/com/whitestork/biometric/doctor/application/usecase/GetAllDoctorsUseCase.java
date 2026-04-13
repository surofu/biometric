package com.whitestork.biometric.doctor.application.usecase;

import com.whitestork.biometric.doctor.application.mapper.DoctorMapper;
import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import com.whitestork.biometric.doctor.infrastructure.persistence.DoctorRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetAllDoctorsUseCase {
  private final DoctorRepository repository;
  private final DoctorMapper mapper;

  public @NonNull List<DoctorResponse> execute() {
    return repository.findAllByOrderByNameAscIdDesc().stream()
        .map(mapper::toResponse)
        .toList();
  }
}
