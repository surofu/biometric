package com.whitestork.biometric.indicator.application.usecase;

import com.whitestork.biometric.indicator.application.mapper.IndicatorMapper;
import com.whitestork.biometric.indicator.application.request.SaveIndicatorRequest;
import com.whitestork.biometric.indicator.application.request.SaveOrUpdateIndicatorRequest;
import com.whitestork.biometric.indicator.application.request.UpdateIndicatorRequest;
import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SaveOrUpdateIndicatorUseCase {
  private final IndicatorMapper mapper;
  private final UpdateIndicatorUseCase updateIndicatorUseCase;
  private final SaveIndicatorUseCase saveIndicatorUseCase;

  public @NonNull IndicatorResponse execute(@NonNull SaveOrUpdateIndicatorRequest request) {
    if (request.id() != null) {
      UpdateIndicatorRequest updateRequest = mapper.toUpdateRequest(request);
      return updateIndicatorUseCase.execute(updateRequest);
    }

    SaveIndicatorRequest saveRequest = mapper.toSaveRequest(request);
    return saveIndicatorUseCase.execute(saveRequest);
  }
}
