package com.whitestork.biometric.profession.infrastructrure.persistence;

import com.whitestork.biometric.profession.application.response.ProfessionResponse;
import com.whitestork.biometric.profession.domain.Profession;
import java.util.List;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.ListCrudRepository;

public interface ProfessionRepository extends ListCrudRepository<Profession, Long> {

  @Query("select p.* from professions p order by p.name, p.id")
  List<ProfessionResponse> findAllResponses();
}
