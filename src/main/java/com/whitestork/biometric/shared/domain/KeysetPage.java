package com.whitestork.biometric.shared.domain;

import java.util.List;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;

public record KeysetPage<T>(
    @NonNull
    List<T> content,
    @Nullable
    String nextCursor,
    boolean hasNext
) {
}