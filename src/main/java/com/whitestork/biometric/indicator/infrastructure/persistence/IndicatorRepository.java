package com.whitestork.biometric.indicator.infrastructure.persistence;

import com.whitestork.biometric.indicator.application.response.IndicatorDetailsResponse;
import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.domain.Indicator;
import java.util.List;
import java.util.Optional;
import org.jspecify.annotations.NonNull;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.ListCrudRepository;

public interface IndicatorRepository extends ListCrudRepository<Indicator, Long> {

  @Query("""
         select distinct
             i.id as id,
             i.name as name,
             i.unit as unit,
             i.reference_min as reference_min,
             i.reference_max as reference_max,
             c.id as category_id,
             c.name as category_name
         from indicators i
         join indicator_categories c on i.category_id = c.id
         join measurements m on m.indicator_id = i.id
         join users u on u.id = m.user_id
         where u.email = :email
         order by i.name, i.id
         """)
  @NonNull List<IndicatorResponse> findAllByUserEmail(@NonNull String email);

  @Query("""
         select
             i.id as id,
             i.name as name,
             i.unit as unit,
             i.reference_min as reference_min,
             i.reference_max as reference_max,
             c.id as category_id,
             c.name as category_name
         from indicators i
         join indicator_categories c on i.category_id = c.id
         order by i.name, i.id desc
         """)
  @NonNull List<IndicatorResponse> findAllResponses();

  boolean existsByName(String name);

  @Query("""
         select
             i.id as id,
             i.name as name,
             i.unit as unit,
             i.reference_min as reference_min,
             i.reference_max as reference_max,
             i.description as description,
             c.id as category_id,
             c.name as category_name
         from indicators i
         join indicator_categories c on i.category_id = c.id
         where i.id = :id
         """)
  Optional<IndicatorDetailsResponse> findByIdDetailsResponse(@NonNull Long id);
}
