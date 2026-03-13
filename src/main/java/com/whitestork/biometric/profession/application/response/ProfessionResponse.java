package com.whitestork.biometric.profession.application.response;

import org.jspecify.annotations.NonNull;

public record ProfessionResponse(
    @NonNull Long id,
    @NonNull String name
) {
}
