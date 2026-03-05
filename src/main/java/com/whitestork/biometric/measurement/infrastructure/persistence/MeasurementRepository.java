package com.whitestork.biometric.measurement.infrastructure.persistence;

import com.whitestork.biometric.analytics.infrastructure.view.MeasurementAnalyticsView;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.domain.Measurement;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import org.jspecify.annotations.NonNull;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

public interface MeasurementRepository extends CrudRepository<Measurement, Long> {

  @Query("""
         select
         m.id as id,
         m.value as value,
         m.date as date,
         i.id as indicator_id,
         i.name as indicator_name,
         i.unit as indicator_unit,
         i.reference_min as indicator_reference_min,
         i.reference_max as indicator_reference_max
         from measurements m
         join indicators i on m.indicator_id = i.id
         join users u on m.user_id = u.id
         where u.email = :email
         order by m.date desc
         """)
  @NonNull Iterable<MeasurementResponse> findAllUserMeasurementResponses(
      @NonNull @Param("email") String email
  );


  @Query("""
         select m.* from measurements m
         join users u on m.user_id = u.id
         where m.id = :id and u.email = :email
         limit 1
         """)
  @NonNull Optional<Measurement> findByIdAndUserEmail(
      @NonNull @Param("id") Long id,
      @NonNull @Param("email") String email
  );

  @Query("""
         select m.* from measurements m
         join users u on m.user_id = u.id
         where m.id = :id and u.email = :email
         limit 1
         """)
  @NonNull Optional<MeasurementResponse> findResponseByIdAndUserEmail(
      @NonNull @Param("id") Long id,
      @NonNull @Param("email") String email
  );

  @Query("""
             select m.value as value, m.date as date
             from (
                 select m.value, m.date,
                        row_number() over (order by m.date desc) as rn
                 from measurements m
                 join users u on m.user_id = u.id
                 where m.indicator_id = :indicatorId and u.email = :email
             ) m
             where m.rn <= 5
             order by m.date
         """)
  @NonNull List<MeasurementAnalyticsView> findAllAnalytics(
      @NonNull @Param("indicatorId") Long indicatorId,
      @NonNull @Param("email") String email
  );

  @Query("""
             select count(m) > 0 from measurements m
             join users u on m.user_id = u.id
             where u.email = :email and m.indicator_id = :indicatorId and m.date = :date
         """)
  boolean existsByUserEmailAndIndicatorIdAndDate(
      @NonNull @Param("email") String email,
      @NonNull @Param("indicatorId") Long indicatorId,
      @NonNull @Param("date") LocalDate date
  );
}
