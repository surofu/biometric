package com.whitestork.biometric.user.infrastructure.persistence;

import com.whitestork.biometric.user.domain.User;
import java.util.Optional;
import org.jspecify.annotations.NonNull;
import org.springframework.data.repository.ListCrudRepository;

public interface UserRepository extends ListCrudRepository<User, Long> {

  boolean existsByEmail(@NonNull String email);

  @NonNull Optional<User> findByEmail(@NonNull String email);
}
