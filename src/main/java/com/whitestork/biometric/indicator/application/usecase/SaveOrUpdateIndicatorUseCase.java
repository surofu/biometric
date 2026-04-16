package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.mapper.IndicatorMapper;
import com.whitestork.biometric.indicator.application.request.SaveIndicatorRequest;
import com.whitestork.biometric.indicator.application.request.SaveOrUpdateIndicatorRequest;
import com.whitestork.biometric.indicator.application.request.UpdateIndicatorRequest;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SaveOrUpdateIndicatorUseCase {
  private final IndicatorMapper mapper;
  private final UpdateIndicatorUseCase updateIndicatorUseCase;
  private final SaveIndicatorUseCase saveIndicatorUseCase;

  public void execute(@NonNull SaveOrUpdateIndicatorRequest request) {
    if (request.id() != null) {
      UpdateIndicatorRequest updateRequest = mapper.toUpdateRequest(request);
      updateIndicatorUseCase.execute(updateRequest);
      return;
    }

    SaveIndicatorRequest saveRequest = mapper.toSaveRequest(request);
    saveIndicatorUseCase.execute(saveRequest);
  }
}
