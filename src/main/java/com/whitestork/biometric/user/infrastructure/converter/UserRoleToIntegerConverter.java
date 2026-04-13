package com.whitestork.biometric.user.infrastructure.converter;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.domain.UserRole;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.convert.WritingConverter;
import org.springframework.stereotype.Component;

@Component
@WritingConverter
public class UserRoleToIntegerConverter implements Converter<UserRole, Integer> {

  @Override
  public @NonNull Integer convert(@Nullable UserRole role) {
    if (role == null) {
      throw new DomainException("Роль обязательна");
    }

    return role.id();
  }
}
