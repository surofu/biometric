package com.whitestork.biometric.user.application.response;

import org.jspecify.annotations.NonNull;

public record UserResponse(
    @NonNull Long id,
    @NonNull String email
) {
}
