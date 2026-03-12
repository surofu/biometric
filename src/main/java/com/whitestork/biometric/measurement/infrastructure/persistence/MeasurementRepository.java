package com.whitestork.biometric.measurement.infrastructure.persistence;

import com.whitestork.biometric.analytics.infrastructure.view.MeasurementAnalyticsView;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.domain.Measurement;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.ListCrudRepository;
import org.springframework.data.repository.query.Param;

public interface MeasurementRepository extends ListCrudRepository<Measurement, Long> {

  @Query("""
         WITH ranked AS (
             SELECT
                 m.id,
                 m.value,
                 m.date,
                 i.id AS indicator_id,
                 i.name AS indicator_name,
                 i.unit AS indicator_unit,
                 i.reference_min AS indicator_reference_min,
                 i.reference_max AS indicator_reference_max,
                 DENSE_RANK() OVER (ORDER BY m.date DESC) AS date_rank
             FROM measurements m
             JOIN indicators i ON m.indicator_id = i.id
             JOIN users u ON m.user_id = u.id
             WHERE u.email = :email
         )
         SELECT * FROM ranked
         WHERE date_rank <= :pageSize
         ORDER BY date DESC, id DESC
         """)
  List<MeasurementResponse> findFirstPageByUser(
      @Param("email") String email,
      @Param("pageSize") int pageSize
  );

  @Query("""
         WITH ranked AS (
             SELECT
                 m.id,
                 m.value,
                 m.date,
                 i.id AS indicator_id,
                 i.name AS indicator_name,
                 i.unit AS indicator_unit,
                 i.reference_min AS indicator_reference_min,
                 i.reference_max AS indicator_reference_max,
                 DENSE_RANK() OVER (ORDER BY m.date DESC) AS date_rank
             FROM measurements m
             JOIN indicators i ON m.indicator_id = i.id
             JOIN users u ON m.user_id = u.id
             WHERE u.email = :email
               AND (m.date < :lastDate OR (m.date = :lastDate AND m.id < :lastId))
         )
         SELECT * FROM ranked
         WHERE date_rank <= :pageSize
         ORDER BY date DESC, id DESC
         """)
  List<MeasurementResponse> findNextPageByUser(
      @Param("email") String email,
      @Param("lastDate") LocalDate lastDate,
      @Param("lastId") long lastId,
      @Param("pageSize") int pageSize
  );

  @Query("""
         SELECT COUNT(DISTINCT m.date)
         FROM measurements m
         JOIN users u ON m.user_id = u.id
         WHERE u.email = :email
           AND (m.date < :lastDate OR (m.date = :lastDate AND m.id < :lastId))
         """)
  long countDistinctDatesAfter(
      @Param("email") String email,
      @Param("lastDate") LocalDate lastDate,
      @Param("lastId") long lastId
  );

  @Query("SELECT COUNT(DISTINCT m.date) FROM measurements m JOIN users u ON m.user_id = u.id WHERE u.email = :email")
  long countAllDistinctDates(@Param("email") String email);


  @Query("""
         select m.* from measurements m
         join users u on m.user_id = u.id
         where m.id = :id and u.email = :email
         limit 1
         """)
  Optional<Measurement> findByIdAndUserEmail(
      @Param("id") Long id,
      @Param("email") String email
  );

  @Query("""
         select m.* from measurements m
         join users u on m.user_id = u.id
         where m.id = :id and u.email = :email
         limit 1
         """)
  Optional<MeasurementResponse> findResponseByIdAndUserEmail(
      @Param("id") Long id,
      @Param("email") String email
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
  List<MeasurementAnalyticsView> findAllAnalytics(
      @Param("indicatorId") Long indicatorId,
      @Param("email") String email
  );

  @Query("""
             select count(m) > 0 from measurements m
             join users u on m.user_id = u.id
             where u.email = :email and m.indicator_id = :indicatorId and m.date = :date
         """)
  boolean existsByUserEmailAndIndicatorIdAndDate(
      @Param("email") String email,
      @Param("indicatorId") Long indicatorId,
      @Param("date") LocalDate date
  );
}
