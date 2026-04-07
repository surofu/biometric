package com.whitestork.biometric.indicatorcategory.application.usecase;

import com.whitestork.biometric.indicatorcategory.application.mapper.IndicatorCategoryMapper;
import com.whitestork.biometric.indicatorcategory.application.request.SaveIndicatorCategoryRequest;
import com.whitestork.biometric.indicatorcategory.application.request.SaveOrUpdateIndicatorCategoryRequest;
import com.whitestork.biometric.indicatorcategory.application.request.UpdateIndicatorCategoryRequest;
import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryResponse;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SaveOrUpdateIndicatorCategoryUseCase {
  private final IndicatorCategoryMapper mapper;
  private final UpdateIndicatorCategoryUseCase updateIndicatorCategoryUseCase;
  private final SaveIndicatorCategoryUseCase saveIndicatorCategoryUseCase;

  public @NonNull IndicatorCategoryResponse execute(
      @NonNull SaveOrUpdateIndicatorCategoryRequest request
  ) {
    if (request.id() != null) {
      UpdateIndicatorCategoryRequest updateRequest = mapper.toUpdateRequest(request);
      return updateIndicatorCategoryUseCase.execute(updateRequest);
    }

    SaveIndicatorCategoryRequest saveRequest = mapper.toSaveRequest(request);
    return saveIndicatorCategoryUseCase.execute(saveRequest);
  }
}
