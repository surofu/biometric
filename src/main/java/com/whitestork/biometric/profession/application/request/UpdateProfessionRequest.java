package com.whitestork.biometric.profession.application.request;

import java.util.List;
import org.jspecify.annotations.NonNull;

public record UpdateProfessionRequest(
    @NonNull Long id,
    @NonNull String name,
    @NonNull String description,
    @NonNull List<Long> doctorIds
) {
}
