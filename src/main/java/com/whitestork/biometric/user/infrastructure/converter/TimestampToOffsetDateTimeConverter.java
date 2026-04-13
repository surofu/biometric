package com.whitestork.biometric.user.infrastructure.converter;

import java.time.OffsetDateTime;
import java.time.ZoneOffset;
import org.jspecify.annotations.Nullable;
import org.springframework.core.convert.converter.Converter;
import org.springframework.data.convert.ReadingConverter;
import org.springframework.stereotype.Component;

@Component
@ReadingConverter
public class TimestampToOffsetDateTimeConverter implements Converter<OffsetDateTime, OffsetDateTime> {

  @Override
  public @Nullable OffsetDateTime convert(@Nullable OffsetDateTime source) {
    if (source != null) {
      return source.withOffsetSameInstant(ZoneOffset.UTC);
    }

    return null;
  }
}
