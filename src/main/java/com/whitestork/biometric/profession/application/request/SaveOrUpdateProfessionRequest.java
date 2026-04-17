package com.whitestork.biometric.profession.application.request;

import java.util.List;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;

public record SaveOrUpdateProfessionRequest(
    @Nullable Long id,
    @NonNull String name,
    @NonNull String description,
    @NonNull List<Long> doctorIds
) {
}
