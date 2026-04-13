package com.whitestork.biometric.profession.application.usecase;

import com.whitestork.biometric.profession.application.component.ProfessionDeleter;
import com.whitestork.biometric.profession.application.component.ProfessionProvider;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class DeleteProfessionUseCase {
  private final ProfessionProvider provider;
  private final ProfessionDeleter deleter;

  public void execute(@NonNull Long id) {
    deleter.delete(provider.withId(id));
  }
}
