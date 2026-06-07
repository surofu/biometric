package com.whitestork.biometric.subscription.infrastructure.persistence;

import com.whitestork.biometric.subscription.domain.PaymentMethod;
import org.springframework.data.repository.ListCrudRepository;

public interface PaymentMethodRepository extends ListCrudRepository<PaymentMethod, Long> {
}
