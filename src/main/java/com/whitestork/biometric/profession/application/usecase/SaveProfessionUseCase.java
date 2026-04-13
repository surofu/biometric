package com.whitestork.biometric.profession.application.usecase;

import com.whitestork.biometric.profession.application.component.ProfessionSaver;
import com.whitestork.biometric.profession.application.component.ProfessionValidator;
import com.whitestork.biometric.profession.application.mapper.ProfessionMapper;
import com.whitestork.biometric.profession.application.request.SaveProfessionRequest;
import com.whitestork.biometric.profession.domain.Profession;
import com.whitestork.biometric.professiondoctor.application.component.ProfessionDoctorSaver;
import com.whitestork.biometric.professiondoctor.domain.ProfessionDoctor;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import java.util.List;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.transaction.annotation.Transactional;

@UseCase
@RequiredArgsConstructor
public class SaveProfessionUseCase {
  private final ProfessionValidator professionValidator;
  private final ProfessionMapper professionMapper;
  private final ProfessionSaver professionSaver;
  private final ProfessionDoctorSaver professionDoctorSaver;

  @Transactional
  public void execute(@NonNull SaveProfessionRequest request) {
    professionValidator.uniqueName(request.name());
    Profession newProfession = professionMapper.toDomain(request);
    Profession savedProfession = professionSaver.save(newProfession);
    Objects.requireNonNull(savedProfession.id(), "Профессия должна иметь ID");
    saveProfessionDoctors(savedProfession.id(), request.doctorIds());
  }

  @Transactional
  protected void saveProfessionDoctors(
      @NonNull Long professionId,
      @NonNull List<Long> doctorIds
  ) {
    List<ProfessionDoctor> professionDoctors = doctorIds.stream()
        .map(doctorId -> new ProfessionDoctor(professionId, doctorId))
        .toList();
    professionDoctorSaver.saveAll(professionDoctors);
  }
}
