package com.whitestork.biometric.doctor.infrastructure.persistence;

import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import com.whitestork.biometric.doctor.domain.Doctor;
import java.util.List;
import org.jspecify.annotations.NonNull;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.ListCrudRepository;

public interface DoctorRepository extends ListCrudRepository<Doctor, Long> {

  @Query("select d.* from doctors d order by d.name, d.id")
  @NonNull List<DoctorResponse> findAllResponses();
}
