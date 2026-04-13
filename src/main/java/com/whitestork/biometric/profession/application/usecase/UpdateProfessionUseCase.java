package com.whitestork.biometric.profession.application.usecase;

import com.whitestork.biometric.profession.application.component.ProfessionProvider;
import com.whitestork.biometric.profession.application.component.ProfessionSaver;
import com.whitestork.biometric.profession.application.component.ProfessionValidator;
import com.whitestork.biometric.profession.application.mapper.ProfessionMapper;
import com.whitestork.biometric.profession.application.request.UpdateProfessionRequest;
import com.whitestork.biometric.profession.domain.Profession;
import com.whitestork.biometric.professiondoctor.domain.ProfessionDoctor;
import com.whitestork.biometric.professiondoctor.infrastructure.ProfessionDoctorRepository;
import com.whitestork.biometric.shared.application.annotation.UseCase;
import java.util.List;
import java.util.Objects;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.transaction.annotation.Transactional;

@UseCase
@RequiredArgsConstructor
public class UpdateProfessionUseCase {
  private final ProfessionProvider professionProvider;
  private final ProfessionDoctorRepository professionDoctorRepository;
  private final ProfessionValidator professionValidator;
  private final ProfessionMapper professionMapper;
  private final ProfessionSaver professionSaver;

  @Transactional
  public void execute(@NonNull UpdateProfessionRequest request) {
    Profession oldProfession = professionProvider.withId(request.id());

    if (!Objects.equals(oldProfession.name(), request.name())) {
      professionValidator.uniqueName(request.name());
    }

    professionSaver.save(professionMapper.toDomain(request));
    saveAndDeleteProfessionDoctors(request.id(), request.doctorIds());
  }

  @Transactional
  protected void saveAndDeleteProfessionDoctors(
      @NonNull Long professionId,
      @NonNull List<Long> doctorIds
  ) {
    List<ProfessionDoctor> oldProfessionDoctors = professionDoctorRepository.findAllByProfessionId(
        professionId
    );
    List<ProfessionDoctor> toDelete = oldProfessionDoctors.stream()
        .filter(professionDoctor -> !doctorIds.contains(professionDoctor.doctorId()))
        .toList();
    List<Long> oldDoctorIds = oldProfessionDoctors.stream()
        .map(ProfessionDoctor::doctorId)
        .toList();
    List<Long> doctorIdsToSave = doctorIds.stream()
        .filter(doctorId -> !oldDoctorIds.contains(doctorId))
        .toList();
    List<ProfessionDoctor> toSave = doctorIdsToSave.stream()
        .map(doctorId -> new ProfessionDoctor(professionId, doctorId))
        .toList();
    professionDoctorRepository.deleteAll(toDelete);
    professionDoctorRepository.saveAll(toSave);
  }
}
