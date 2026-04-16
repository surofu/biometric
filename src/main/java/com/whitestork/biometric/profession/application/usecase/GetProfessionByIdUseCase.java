package com.whitestork.biometric.profession.application.usecase;

import com.whitestork.biometric.profession.application.component.ProfessionProvider;
import com.whitestork.biometric.profession.application.response.ProfessionDetailsResponse;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class GetProfessionByIdUseCase {
  private final ProfessionProvider provider;

  public @NonNull ProfessionDetailsResponse execute(@NonNull Long id) {
    return provider.withIdDetailsResponse(id);
  }
}
