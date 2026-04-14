package com.whitestork.biometric.user.infrastructure.converter;

import java.sql.Timestamp;
import java.time.OffsetDateTime;
import org.jspecify.annotations.Nullable;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.convert.WritingConverter;
import org.springframework.stereotype.Component;

@Component
@WritingConverter
public class OffsetDateTimeToTimestampConverter implements Converter<OffsetDateTime, Timestamp> {

  @Override
  public @Nullable Timestamp convert(@Nullable OffsetDateTime source) {
    if (source != null) {
      return Timestamp.from(source.toInstant());
    }

    return null;
  }
}
