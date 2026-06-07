package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.response.IndicatorDetailsResponse;
import com.whitestork.biometric.indicator.application.component.IndicatorProvider;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class GetIndicatorByIdAndUserIdUseCase {
  private final IndicatorProvider provider;

  public @NonNull IndicatorDetailsResponse execute(@NonNull Long id, @NonNull Long userId) {
    return provider.withIdAndUserIdDetailsResponse(id, userId);
  }
}
