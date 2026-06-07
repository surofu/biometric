package com.whitestork.biometric.subscription.infrastructure.persistence;

import com.whitestork.biometric.subscription.domain.Subscription;
import java.util.Optional;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.ListCrudRepository;
import org.springframework.data.repository.query.Param;

public interface SubscriptionRepository extends ListCrudRepository<Subscription, Long> {

  @Query("""
      SELECT * FROM user_subscriptions
      WHERE user_id = :userId
        AND status = 10
        AND end_date > now()
      ORDER BY end_date DESC
      LIMIT 1
      """)
  Optional<Subscription> findActiveByUserId(@Param("userId") Long userId);
}
