package com.whitestork.biometric.profession.application.usecase;

import com.whitestork.biometric.profession.application.mapper.ProfessionMapper;
import com.whitestork.biometric.profession.application.request.SaveOrUpdateProfessionRequest;
import com.whitestork.biometric.profession.application.request.SaveProfessionRequest;
import com.whitestork.biometric.profession.application.request.UpdateProfessionRequest;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;

@UseCase
@RequiredArgsConstructor
public class SaveOrUpdateProfessionUseCase {
  private final ProfessionMapper mapper;
  private final SaveProfessionUseCase saveProfessionUseCase;
  private final UpdateProfessionUseCase updateProfessionUseCase;

  public void execute(@NonNull SaveOrUpdateProfessionRequest request) {
    if (request.id() != null) {
      UpdateProfessionRequest updateRequest = mapper.toUpdateRequest(request);
      updateProfessionUseCase.execute(updateRequest);
      return;
    }

    SaveProfessionRequest saveRequest = mapper.toSaveRequest(request);
    saveProfessionUseCase.execute(saveRequest);
  }
}
