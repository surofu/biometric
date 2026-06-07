package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.infrastructure.persistence.IndicatorRepository;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class GetAllIndicatorsForUserUseCase {

  private final IndicatorRepository repository;

  public @NonNull List<IndicatorResponse> execute(@NonNull Long userId) {
    return repository.findAllResponsesWithUserId(userId);
  }
}