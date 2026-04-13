package com.whitestork.biometric.doctor.application.request;

import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;

public record SaveOrUpdateDoctorRequest(
    @Nullable Long id,
    @NonNull String name
) {
}
