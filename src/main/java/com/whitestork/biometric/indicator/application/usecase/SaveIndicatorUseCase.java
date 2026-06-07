package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.mapper.IndicatorMapper;
import com.whitestork.biometric.indicator.application.request.SaveIndicatorRequest;
import com.whitestork.biometric.indicator.application.component.IndicatorSaver;
import com.whitestork.biometric.indicator.application.component.IndicatorValidator;
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

  public void execute(@NonNull SaveIndicatorRequest request) {
    if (request.userId() != null) {
      validator.uniqueNameWithUserId(request.name(), request.userId());
    } else {
      validator.uniqueName(request.name());
    }

    Indicator newIndicator = mapper.toDomain(request);
    saver.save(newIndicator);
  }
}
