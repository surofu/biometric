package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.mapper.IndicatorMapper;
import com.whitestork.biometric.indicator.application.request.SaveIndicatorRequest;
import com.whitestork.biometric.indicator.application.service.IndicatorProvider;
import com.whitestork.biometric.indicator.application.service.IndicatorSaver;
import com.whitestork.biometric.indicator.application.service.IndicatorValidator;
import com.whitestork.biometric.indicator.domain.Indicator;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SaveIndicatorUseCase {
  private final IndicatorValidator validator;
  private final IndicatorMapper mapper;
  private final IndicatorSaver saver;
  private final IndicatorProvider provider;

  public void execute(@NonNull SaveIndicatorRequest request) {
    validator.uniqueName(request.name());
    Indicator newIndicator = mapper.toDomain(request);
    saver.save(newIndicator);
  }
}
