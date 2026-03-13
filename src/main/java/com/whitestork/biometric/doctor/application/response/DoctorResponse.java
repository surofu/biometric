package com.whitestork.biometric.doctor.application.response;

import org.jspecify.annotations.NonNull;

public record DoctorResponse(
    @NonNull Long id,
    @NonNull String name
) {
}
