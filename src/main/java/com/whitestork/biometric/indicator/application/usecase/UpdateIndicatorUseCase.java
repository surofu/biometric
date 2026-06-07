package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.mapper.IndicatorMapper;
import com.whitestork.biometric.indicator.application.request.UpdateIndicatorRequest;
import com.whitestork.biometric.indicator.application.component.IndicatorProvider;
import com.whitestork.biometric.indicator.application.component.IndicatorSaver;
import com.whitestork.biometric.indicator.application.component.IndicatorValidator;
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
      if (request.userId() != null) {
        validator.uniqueNameWithUserId(request.name(), request.userId());
      } else {
        validator.uniqueName(request.name());
      }
    }

    Indicator updatedIndicator = mapper.toDomain(request);
    saver.save(updatedIndicator);
  }
}
