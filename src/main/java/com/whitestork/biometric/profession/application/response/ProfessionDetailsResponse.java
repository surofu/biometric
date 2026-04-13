package com.whitestork.biometric.profession.application.response;

import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import java.util.List;
import org.jspecify.annotations.NonNull;

public record ProfessionDetailsResponse(
    @NonNull Long id,
    @NonNull String name,
    @NonNull List<DoctorResponse> doctors
    ) {
}
