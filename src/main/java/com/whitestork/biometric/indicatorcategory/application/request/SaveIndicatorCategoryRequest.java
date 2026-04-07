package com.whitestork.biometric.indicatorcategory.application.request;

import java.util.List;
import org.jspecify.annotations.NonNull;

public record SaveIndicatorCategoryRequest(
    @NonNull String name,
    @NonNull String description,
    @NonNull List<Long> indicatorIds
) {
}
