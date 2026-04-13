package com.whitestork.biometric.professiondoctor.domain;

import lombok.With;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.data.annotation.Id;
import org.springframework.data.relational.core.mapping.Table;

@With
@Table("professions_doctors")
public record ProfessionDoctor(
    @Id
    @Nullable Long id,
    @NonNull Long professionId,
    @NonNull Long doctorId
) {

  public ProfessionDoctor(@NonNull Long professionId, @NonNull Long doctorId) {
    this(null, professionId, doctorId);
  }
}
