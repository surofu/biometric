package com.whitestork.biometric.indicator.interfaces;

import com.whitestork.biometric.indicator.application.request.SaveOrUpdateIndicatorRequest;
import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.application.service.IndicatorProvider;
import com.whitestork.biometric.indicator.application.usecase.DeleteIndicatorByIdUseCase;
import com.whitestork.biometric.indicator.application.usecase.GetAllIndicatorsUseCase;
import com.whitestork.biometric.indicator.application.usecase.SaveOrUpdateIndicatorUseCase;
import com.whitestork.biometric.indicatorcategory.application.usecase.GetAllIndicatorCategoriesUseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@RequestMapping("admin/indicators")
public class IndicatorController {
  private final GetAllIndicatorsUseCase getAllIndicatorsUseCase;
  private final IndicatorProvider indicatorProvider;
  private final SaveOrUpdateIndicatorUseCase saveOrUpdateIndicatorUseCase;
  private final DeleteIndicatorByIdUseCase deleteIndicatorByIdUseCase;
  private final GetAllIndicatorCategoriesUseCase getAllIndicatorCategoriesUseCase;

  @ModelAttribute
  public void commonAttributes(@NonNull Model model) {
    model.addAttribute("request", new SaveOrUpdateIndicatorRequest());
  }

  @GetMapping
  @PreAuthorize("isAuthenticated()")
  public @NonNull String all(@NonNull Model model) {
    model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
    return "admin/indicators";
  }

  @GetMapping("/add")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String add(@NonNull Model model) {
    model.addAttribute("categories", getAllIndicatorCategoriesUseCase.execute());
    return "admin/indicator-form";
  }

  @GetMapping("/{id}/edit")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String edit(@NonNull @PathVariable Long id, @NonNull Model model) {
    IndicatorResponse response = indicatorProvider.withIdResponse(id);
    SaveOrUpdateIndicatorRequest request = new SaveOrUpdateIndicatorRequest(response);
    model.addAttribute("request", request);
    model.addAttribute("categories", getAllIndicatorCategoriesUseCase.execute());
    return "admin/indicator-form";
  }

  @PostMapping("/save")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String save(
      @NonNull @ModelAttribute("request") SaveOrUpdateIndicatorRequest request,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    try {
      IndicatorResponse saved = saveOrUpdateIndicatorUseCase.execute(request);
      redirectAttributes.addFlashAttribute("successMessage", "Индикатор успешно сохранен");
      return "redirect:/admin/indicators/%s/edit".formatted(saved.id());
    } catch (Exception exception) {
      redirectAttributes.addFlashAttribute(
          "errorMessage",
          "Ошибка при сохранении: " + exception.getMessage()
      );

      if (request.id() != null) {
        return "redirect:/admin/indicators/%s/edit".formatted(request.id());
      }
      return "redirect:/admin/indicators/add";
    }
  }

  @DeleteMapping("/{id}")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String delete(
      @NonNull @PathVariable Long id,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    try {
      deleteIndicatorByIdUseCase.execute(id);
      redirectAttributes.addFlashAttribute("successMessage", "Индикатор успешно удален");
    } catch (Exception exception) {
      redirectAttributes.addFlashAttribute(
          "errorMessage",
          "Ошибка при удалении: " + exception.getMessage()
      );
    }
    return "redirect:/admin/indicators";
  }
}
