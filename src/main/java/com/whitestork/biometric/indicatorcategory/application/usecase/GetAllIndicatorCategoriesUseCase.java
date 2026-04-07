package com.whitestork.biometric.indicatorcategory.application.usecase;

import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryResponse;
import com.whitestork.biometric.indicatorcategory.infrastructure.persistence.IndicatorCategoryRepository;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetAllIndicatorCategoriesUseCase {
  private final IndicatorCategoryRepository repository;

  public @NonNull List<IndicatorCategoryResponse> execute() {
    return repository.findAllResponses();
  }
}
