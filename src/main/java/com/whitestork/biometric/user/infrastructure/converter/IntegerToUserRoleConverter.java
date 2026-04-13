package com.whitestork.biometric.user.infrastructure.converter;

import com.whitestork.biometric.shared.domain.exception.DomainException;
import com.whitestork.biometric.user.domain.UserRole;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.convert.ReadingConverter;
import org.springframework.stereotype.Component;

@Component
@ReadingConverter
public class IntegerToUserRoleConverter implements Converter<Integer, UserRole> {

  @Override
  public @NonNull UserRole convert(@Nullable Integer source) {
    if (source == null) {
      throw new DomainException("ID роли обязателен");
    }

    return UserRole.fromId(source);
  }
}
