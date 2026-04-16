package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.mapper.IndicatorMapper;
import com.whitestork.biometric.indicator.application.request.UpdateIndicatorRequest;
import com.whitestork.biometric.indicator.application.service.IndicatorProvider;
import com.whitestork.biometric.indicator.application.service.IndicatorSaver;
import com.whitestork.biometric.indicator.application.service.IndicatorValidator;
import com.whitestork.biometric.indicator.domain.Indicator;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class UpdateIndicatorUseCase {
  private final IndicatorValidator validator;
  private final IndicatorMapper mapper;
  private final IndicatorSaver saver;
  private final IndicatorProvider provider;

  public void execute(@NonNull UpdateIndicatorRequest request) {
    Indicator oldIndicator = provider.withId(request.id());

    if (!Objects.equals(oldIndicator.name(), request.name())) {
      validator.uniqueName(request.name());
    }

    Indicator updatedIndicator = mapper.toDomain(request);
    saver.save(updatedIndicator);
  }
}
