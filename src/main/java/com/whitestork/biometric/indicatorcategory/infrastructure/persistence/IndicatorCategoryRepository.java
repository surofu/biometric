package com.whitestork.biometric.indicatorcategory.infrastructure.persistence;

import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryResponse;
import com.whitestork.biometric.indicatorcategory.domain.IndicatorCategory;
import java.util.List;
import org.jspecify.annotations.NonNull;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.ListCrudRepository;

public interface IndicatorCategoryRepository extends ListCrudRepository<IndicatorCategory, Long> {
  @NonNull Boolean existsByName(String name);

  @Query("""
         select c.* from indicator_categories c
         order by c.name, c.id desc
         """)
  @NonNull List<IndicatorCategoryResponse> findAllResponses();
}
