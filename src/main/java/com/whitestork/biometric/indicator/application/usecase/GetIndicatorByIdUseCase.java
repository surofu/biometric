package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.response.IndicatorDetailsResponse;
import com.whitestork.biometric.indicator.application.service.IndicatorProvider;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class GetIndicatorByIdUseCase {
  private final IndicatorProvider provider;

  public @NonNull IndicatorDetailsResponse execute(@NonNull Long id) {
    return provider.withIdDetailsResponse(id);
  }
}
