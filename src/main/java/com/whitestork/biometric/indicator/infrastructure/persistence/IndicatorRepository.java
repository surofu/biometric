package com.whitestork.biometric.indicator.infrastructure.persistence;

import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.domain.Indicator;
import java.util.List;
import org.jspecify.annotations.NonNull;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.ListCrudRepository;

public interface IndicatorRepository extends ListCrudRepository<Indicator, Long> {

  @Query("select * from indicators order by name, id")
  @NonNull List<IndicatorResponse> findAllResponses();

  @Query("""
         select distinct i.*
         from indicators i
         join measurements m on m.indicator_id = i.id
         join users u on u.id = m.user_id
         where u.email = :email
         order by i.name, i.id
         """)
  @NonNull List<IndicatorResponse> findAllAvailable(@NonNull String email);
}
