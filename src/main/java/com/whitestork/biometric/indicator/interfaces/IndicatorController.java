package com.whitestork.biometric.indicator.interfaces;

import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.application.usecase.GetAllIndicatorsUseCase;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("indicators")
public class IndicatorController {
  private final GetAllIndicatorsUseCase getAllIndicatorsUseCase;

  @GetMapping
  @PreAuthorize("isAuthenticated()")
  public String all(Model model) {
    Iterable<IndicatorResponse> indicators = getAllIndicatorsUseCase.execute();
    model.addAttribute("indicators", indicators);
    return "indicator/indicators";
  }
}
