package com.whitestork.biometric.user.application.request;

import org.jspecify.annotations.NonNull;

public record RegisterUserRequest(
    @NonNull String email,
    @NonNull String password,
    @NonNull Boolean agreement
) {
}
