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
         select
             i.id as id,
             i.user_id as user_id,
             i.name as name,
             i.unit as unit,
             i.reference_min as reference_min,
             i.reference_max as reference_max,
             c.id as category_id,
             c.name as category_name
         from indicators i
         left join indicator_categories c on i.category_id = c.id
         join measurements m on m.indicator_id = i.id
         where m.user_id = (select u.id from users u where u.email = :email)
         group by i.id, i.user_id, i.name, i.unit, i.reference_min, i.reference_max, c.id, c.name
         order by i.user_id, i.name, i.id
         """)
  @NonNull List<IndicatorResponse> findAllByUserEmail(@NonNull String email);

  @Query("""
         select
             i.id as id,
             i.user_id as user_id,
             i.name as name,
             i.unit as unit,
             i.reference_min as reference_min,
             i.reference_max as reference_max,
             c.id as category_id,
             c.name as category_name
         from indicators i
         left join indicator_categories c on i.category_id = c.id
         where i.user_id is null
         order by i.name, i.id desc
         """)
  @NonNull List<IndicatorResponse> findAllPublicResponses();

  @Query("""
         select
             i.id as id,
             i.user_id as user_id,
             i.name as name,
             i.unit as unit,
             i.reference_min as reference_min,
             i.reference_max as reference_max,
             c.id as category_id,
             c.name as category_name
         from indicators i
         left join indicator_categories c on i.category_id = c.id
         order by i.user_id, i.name, i.id desc
         """)
  @NonNull List<IndicatorResponse> findAllResponses();

  @Query("""
         select
             i.id as id,
             i.user_id as user_id,
             i.name as name,
             i.unit as unit,
             i.reference_min as reference_min,
             i.reference_max as reference_max,
             c.id as category_id,
             c.name as category_name
         from indicators i
         left join indicator_categories c on i.category_id = c.id
         where i.user_id is null or i.user_id = :userId
         order by i.user_id, i.name, i.id desc
         """)
  @NonNull List<IndicatorResponse> findAllResponsesWithUserId(@NonNull Long userId);

  @Query("""
         select
             i.id as id,
             i.user_id as user_id,
             i.name as name,
             i.unit as unit,
             i.reference_min as reference_min,
             i.reference_max as reference_max,
             c.id as category_id,
             c.name as category_name
         from indicators i
         left join indicator_categories c on i.category_id = c.id
         where i.user_id = :userId
         order by i.name, i.id desc
         """)
  @NonNull List<IndicatorResponse> findAllResponsesByUserId(@NonNull Long userId);


  @Query("""
         select count(i.id) > 0
         from indicators i
         where i.name = :name and i.user_id is null
         """)
  boolean existsByName(String name);

  @Query("""
         select count(i.id) > 0
         from indicators i
         where i.name = :name and i.user_id = :userId
         """)
  boolean existsByNameAndUserId(String name, Long userId);

  @Query("""
         select
             i.id as id,
             i.user_id as user_id,
             i.name as name,
             i.unit as unit,
             i.reference_min as reference_min,
             i.reference_max as reference_max,
             i.description as description,
             c.id as category_id,
             c.name as category_name
         from indicators i
         join indicator_categories c on i.category_id = c.id
         where i.id = :id and i.user_id is null
         """)
  Optional<IndicatorDetailsResponse> findByIdPublicDetailsResponse(@NonNull Long id);

  @Query("""
         select
             i.id as id,
             i.user_id as user_id,
             i.name as name,
             i.unit as unit,
             i.reference_min as reference_min,
             i.reference_max as reference_max,
             i.description as description,
             c.id as category_id,
             c.name as category_name
         from indicators i
         left join indicator_categories c on i.category_id = c.id
         where i.id = :id and (i.user_id is null or i.user_id = :userId)
         """)
  Optional<IndicatorDetailsResponse> findByIdAndUserIdDetailsResponse(
      @NonNull Long id,
      @NonNull Long userId
  );

  Optional<Indicator> findByIdAndUserId(Long id, Long userId);
}
