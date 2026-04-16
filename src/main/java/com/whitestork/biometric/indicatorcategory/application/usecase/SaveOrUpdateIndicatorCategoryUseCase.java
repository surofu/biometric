package com.whitestork.biometric.indicatorcategory.application.usecase;

import com.whitestork.biometric.indicatorcategory.application.mapper.IndicatorCategoryMapper;
import com.whitestork.biometric.indicatorcategory.application.request.SaveIndicatorCategoryRequest;
import com.whitestork.biometric.indicatorcategory.application.request.SaveOrUpdateIndicatorCategoryRequest;
import com.whitestork.biometric.indicatorcategory.application.request.UpdateIndicatorCategoryRequest;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SaveOrUpdateIndicatorCategoryUseCase {
  private final IndicatorCategoryMapper mapper;
  private final UpdateIndicatorCategoryUseCase updateIndicatorCategoryUseCase;
  private final SaveIndicatorCategoryUseCase saveIndicatorCategoryUseCase;

  public void execute(@NonNull SaveOrUpdateIndicatorCategoryRequest request) {
    if (request.id() != null) {
      UpdateIndicatorCategoryRequest updateRequest = mapper.toUpdateRequest(request);
      updateIndicatorCategoryUseCase.execute(updateRequest);
      return;
    }

    SaveIndicatorCategoryRequest saveRequest = mapper.toSaveRequest(request);
    saveIndicatorCategoryUseCase.execute(saveRequest);
  }
}
