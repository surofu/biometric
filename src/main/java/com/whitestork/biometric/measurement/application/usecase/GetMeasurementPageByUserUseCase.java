package com.whitestork.biometric.measurement.application.usecase;

import com.whitestork.biometric.measurement.application.response.MeasurementGroupResponse;
import com.whitestork.biometric.measurement.application.response.MeasurementResponse;
import com.whitestork.biometric.measurement.infrastructure.persistence.MeasurementRepository;
import com.whitestork.biometric.shared.domain.KeysetCursor;
import com.whitestork.biometric.shared.domain.KeysetPage;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.stream.Collectors;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class GetMeasurementPageByUserUseCase {
  private final MeasurementRepository repository;

  @NonNull
  public KeysetPage<MeasurementGroupResponse> execute(
      @NonNull String email,
      @Nullable KeysetCursor cursor,
      int pageSize
  ) {
    List<MeasurementResponse> measurements;
    long totalDatesAfter;

    if (cursor == null) {
      measurements = repository.findFirstPageByUser(email, pageSize);
      totalDatesAfter = repository.countAllDistinctDates(email);
    } else {
      measurements = repository.findNextPageByUser(email, cursor.date(), cursor.id(), pageSize);
      totalDatesAfter = repository.countDistinctDatesAfter(email, cursor.date(), cursor.id());
    }

    List<MeasurementGroupResponse> content = buildGroups(measurements);
    boolean hasNextPage = totalDatesAfter > pageSize;

    if (hasNextPage && !measurements.isEmpty()) {
      String nextCursor = buildNextCursor(measurements.getLast());
      return new KeysetPage<>(content, nextCursor, true);
    }

    return new KeysetPage<>(content, null, hasNextPage);
  }

  @NonNull
  private String buildNextCursor(@NonNull MeasurementResponse last) {
    LocalDate nextCursorDate = last.date();
    Long nextCursorId = last.id();
    KeysetCursor cursor = new KeysetCursor(nextCursorDate, nextCursorId);
    return cursor.toString();
  }

  @NonNull
  private List<MeasurementGroupResponse> buildGroups(
      @NonNull List<MeasurementResponse> measurements
  ) {
    return measurements.stream()
        .collect(Collectors.groupingBy(
            MeasurementResponse::date,
            LinkedHashMap::new,
            Collectors.toList()
        ))
        .entrySet().stream()
        .map(entry -> new MeasurementGroupResponse(entry.getKey(), entry.getValue()))
        .toList();
  }
}
