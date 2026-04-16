package com.whitestork.biometric.indicatorcategory.infrastructure.persistence;

import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryDetailsResponse;
import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryResponse;
import com.whitestork.biometric.indicatorcategory.domain.IndicatorCategory;
import java.util.List;
import java.util.Optional;
import org.jspecify.annotations.NonNull;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.ListCrudRepository;

public interface IndicatorCategoryRepository extends ListCrudRepository<IndicatorCategory, Long> {
  @NonNull Boolean existsByName(String name);

  @Query("""
         select
             c.id as id,
             c.name as name
         from indicator_categories c
         order by c.name, c.id desc
         """)
  @NonNull List<IndicatorCategoryResponse> findAllResponses();

  @Query("""
         select
             c.id as id,
             c.name as name,
             c.description as description
         from indicator_categories c
         where c.id = :id
         """)
  @NonNull Optional<IndicatorCategoryDetailsResponse> findByIdDetailsResponse(@NonNull Long id);


}
