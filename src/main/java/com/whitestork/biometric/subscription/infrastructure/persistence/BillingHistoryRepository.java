package com.whitestork.biometric.subscription.infrastructure.persistence;

import com.whitestork.biometric.subscription.domain.BillingHistory;
import org.springframework.data.repository.ListCrudRepository;

public interface BillingHistoryRepository extends ListCrudRepository<BillingHistory, Long> {
}
