package com.whitestork.biometric.user.infrastructure.converter;

import java.sql.Timestamp;
import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import org.jspecify.annotations.Nullable;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.convert.ReadingConverter;
import org.springframework.stereotype.Component;

@Component
@ReadingConverter
public class OffsetDateTimeToTimestampConverter implements Converter<Timestamp, OffsetDateTime> {

  @Override
  public @Nullable OffsetDateTime convert(@Nullable Timestamp source) {
    if (source != null) {
      return OffsetDateTime.ofInstant(source.toInstant(), ZoneOffset.UTC);
    }

    return null;
  }
}
