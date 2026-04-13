package com.whitestork.biometric.doctor.application.request;

import org.jspecify.annotations.NonNull;

public record UpdateDoctorRequest(
    @NonNull Long id,
    @NonNull String name
) {
}
