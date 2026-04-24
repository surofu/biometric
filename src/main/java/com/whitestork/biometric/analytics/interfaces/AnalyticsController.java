package com.whitestork.biometric.analytics.interfaces;

import com.whitestork.biometric.analytics.application.response.AnalyticsResponse;
import com.whitestork.biometric.analytics.application.usecase.GetAnalyticsUseCase;
import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.application.usecase.GetMyAvailableIndicatorsUseCase;
import com.whitestork.biometric.user.domain.User;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/analytics")
@PreAuthorize("isAuthenticated()")
public class AnalyticsController {
  private final GetMyAvailableIndicatorsUseCase getMyAvailableIndicatorsUseCase;
  private final GetAnalyticsUseCase getAnalyticsUseCase;

  @GetMapping
  public @NonNull String selectAnalytics(
      @NonNull @AuthenticationPrincipal User user,
      @NonNull Model model
  ) {
    List<IndicatorResponse> indicators = getMyAvailableIndicatorsUseCase.execute(
        user.email()
    );
    model.addAttribute("indicators", indicators);
    return "analytics/select";
  }

  @GetMapping("{indicatorId}")
  public @NonNull String showMeasurementAnalytics(
      @NonNull @PathVariable Long indicatorId,
      @NonNull @AuthenticationPrincipal User user,
      @NonNull Model model
  ) {
    AnalyticsResponse analyticsResponse = getAnalyticsUseCase.execute(
        indicatorId,
        user.email()
    );

    model.addAttribute("analytics", analyticsResponse);
    return "analytics/chart";
  }
}
