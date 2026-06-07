package com.whitestork.biometric.subscription.infrastructure.persistence;

import com.whitestork.biometric.subscription.domain.Plan;
import org.springframework.data.repository.ListCrudRepository;

public interface PlanRepository extends ListCrudRepository<Plan, Long> {
}
