package com.whitestork.biometric.user.infrastructure.persistence;

import com.whitestork.biometric.user.domain.User;
import java.util.Optional;
import org.springframework.data.repository.ListCrudRepository;

public interface UserRepository extends ListCrudRepository<User, Long> {

  boolean existsByEmail(String email);

  Optional<User> findByEmail(String email);
}
