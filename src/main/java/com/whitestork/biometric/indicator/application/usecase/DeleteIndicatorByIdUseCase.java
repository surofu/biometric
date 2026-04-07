package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.service.IndicatorDeleter;
import com.whitestork.biometric.indicator.application.service.IndicatorProvider;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class DeleteIndicatorByIdUseCase {
  private final IndicatorProvider provider;
  private final IndicatorDeleter deleter;

  public void execute(@NonNull Long id) {
    deleter.delete(provider.withId(id));
  }
}
