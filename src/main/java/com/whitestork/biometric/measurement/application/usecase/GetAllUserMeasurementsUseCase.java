package com.whitestork.biometric.measurement.application.usecase;

import com.whitestork.biometric.measurement.application.response.MeasurementGroupResponse;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.infrastructure.persistence.MeasurementRepository;
import java.util.LinkedHashMap;
import java.util.stream.Collectors;
import java.util.stream.StreamSupport;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetAllUserMeasurementsUseCase {
  private final MeasurementRepository repository;

  @NonNull
  public Iterable<MeasurementGroupResponse> execute(@NonNull String email) {
    return StreamSupport.stream(repository.findAllUserMeasurementResponses(email).spliterator(),
            false)
        .collect(Collectors.groupingBy(
            MeasurementResponse::date,
            LinkedHashMap::new,
            Collectors.toList()
        ))
        .entrySet().stream()
        .map(entry -> new MeasurementGroupResponse(entry.getKey(), entry.getValue()))
        .toList();
  }
}
