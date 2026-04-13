package com.whitestork.biometric.doctor.infrastructure.persistence;

import com.whitestork.biometric.doctor.domain.Doctor;
import java.util.List;
import org.jspecify.annotations.NonNull;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.ListCrudRepository;
import org.springframework.data.repository.query.Param;

public interface DoctorRepository extends ListCrudRepository<Doctor, Long> {

  @Query("""
         select d.* from doctors d
         join professions_doctors pd on d.id = pd.doctor_id
         where pd.profession_id = :professionId
         order by d.name, d.id desc
         """)
  @NonNull List<Doctor> findAllByProfessionId(@Param("professionId") @NonNull Long professionId);

  @NonNull List<Doctor> findAllByOrderByNameAscIdDesc();

  boolean existsByName(String name);
}
