package com.whitestork.biometric.profession.infrastructrure.persistence;

import com.whitestork.biometric.profession.application.response.ProfessionResponse;
import com.whitestork.biometric.profession.domain.Profession;
import com.whitestork.biometric.profession.infrastructrure.projection.ProfessionDetailsProjection;
import java.util.List;
import java.util.Optional;
import org.jspecify.annotations.NonNull;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.ListCrudRepository;
import org.springframework.data.repository.query.Param;

public interface ProfessionRepository extends ListCrudRepository<Profession, Long> {

  @Query("""
         select
             p.id as id,
             p.name as name
         from professions p
         order by p.name, p.id desc
         """)
  @NonNull List<ProfessionResponse> findAllResponses();

  @Query("""
          select
             p.id as id,
             p.name as name,
             p.description as description
         from professions p
         where p.id = :id
         order by p.name, p.id desc
         """)
  @NonNull Optional<ProfessionDetailsProjection> findByIdDetailsResponse(@Param("id") @NonNull Long id);

  boolean existsByName(@NonNull String name);
}
