package com.whitestork.biometric.indicatorcategory.application.request;

import java.util.List;
import org.jspecify.annotations.NonNull;
import org.jspecify.annotations.Nullable;

public record SaveOrUpdateIndicatorCategoryRequest(
    @Nullable Long id,
    @NonNull String name,
    @NonNull String description,
    @NonNull List<Long> indicatorIds
) {
}
