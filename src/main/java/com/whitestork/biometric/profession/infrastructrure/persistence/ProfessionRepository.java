package com.whitestork.biometric.profession.infrastructrure.persistence;

import com.whitestork.biometric.profession.domain.Profession;
import java.util.List;
import org.springframework.data.repository.ListCrudRepository;

public interface ProfessionRepository extends ListCrudRepository<Profession, Long> {

  List<Profession> findAllByOrderByNameAscIdDesc();

  boolean existsByName(String name);
}
