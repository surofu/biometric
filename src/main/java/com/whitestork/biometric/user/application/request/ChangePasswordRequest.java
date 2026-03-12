package com.whitestork.biometric.user.application.request;

import org.jspecify.annotations.NonNull;

public record ChangePasswordRequest(
    @NonNull String email,
    @NonNull String oldPassword,
    @NonNull String newPassword
) {
}
