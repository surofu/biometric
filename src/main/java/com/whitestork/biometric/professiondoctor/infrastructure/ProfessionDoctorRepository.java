package com.whitestork.biometric.professiondoctor.infrastructure;

import com.whitestork.biometric.professiondoctor.domain.ProfessionDoctor;
import java.util.List;
import java.util.Optional;
import org.jspecify.annotations.NonNull;
import org.springframework.data.repository.ListCrudRepository;

public interface ProfessionDoctorRepository extends ListCrudRepository<ProfessionDoctor, Long> {
  @NonNull Optional<ProfessionDoctor> findByProfessionIdAndDoctorId(
      @NonNull Long professionId,
      @NonNull Long doctorId
  );

  boolean existsByProfessionIdAndDoctorId(Long professionId, Long doctorId);

  List<ProfessionDoctor> findAllByProfessionId(Long professionId);
}
