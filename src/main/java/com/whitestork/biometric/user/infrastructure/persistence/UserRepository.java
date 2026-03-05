package com.whitestork.biometric.user.infrastructure.persistence;

import com.whitestork.biometric.user.domain.User;
import java.util.Optional;
import org.springframework.data.repository.CrudRepository;

public interface UserRepository extends CrudRepository<User, Long> {

  boolean existsByEmail(String email);

  Optional<User> findByEmail(String email);
}
