package com.whitestork.biometric.doctor.infrastructure.persistence;

import com.whitestork.biometric.doctor.application.response.DoctorDetailsResponse;
import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import com.whitestork.biometric.doctor.domain.Doctor;
import java.util.List;
import java.util.Optional;
import org.jspecify.annotations.NonNull;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.ListCrudRepository;
import org.springframework.data.repository.query.Param;

public interface DoctorRepository extends ListCrudRepository<Doctor, Long> {

  @Query("""
         select
             d.id as id,
             d.name as name
         from doctors d
         join professions_doctors pd on d.id = pd.doctor_id
         where pd.profession_id = :professionId
         order by d.name, d.id desc
         """)
  @NonNull List<DoctorResponse> findAllResponsesByProfessionId(@Param("professionId") @NonNull Long professionId);

  @Query("""
         select
             d.id as id,
             d.name as name
         from doctors d
         order by d.name, d.id desc
         """)
  @NonNull List<DoctorResponse> findAllResponses();

  @Query("""
         select
             d.id as id,
             d.name as name,
             d.description as description
         from doctors d
         where d.id = :id
         """)
  @NonNull Optional<DoctorDetailsResponse> findByIdDetailsResponse(@NonNull Long id);

  boolean existsByName(@NonNull String name);
}
