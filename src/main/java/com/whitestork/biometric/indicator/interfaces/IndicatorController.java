package com.whitestork.biometric.indicator.interfaces;

import com.whitestork.biometric.indicator.application.request.SaveOrUpdateIndicatorRequest;
import com.whitestork.biometric.indicator.application.response.IndicatorResponse;
import com.whitestork.biometric.indicator.application.service.IndicatorProvider;
import com.whitestork.biometric.indicator.application.usecase.DeleteIndicatorByIdUseCase;
import com.whitestork.biometric.indicator.application.usecase.GetAllIndicatorsUseCase;
import com.whitestork.biometric.indicator.application.usecase.SaveOrUpdateIndicatorUseCase;
import com.whitestork.biometric.indicatorcategory.application.usecase.GetAllIndicatorCategoriesUseCase;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
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

  @GetMapping
  @PreAuthorize("isAuthenticated()")
  public @NonNull String all(@NonNull Model model) {
    model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
    return "admin/indicators";
  }

  @GetMapping("/add")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String addForm(@NonNull Model model) {
    model.addAttribute("request", new SaveOrUpdateIndicatorRequest());
    model.addAttribute("categories", getAllIndicatorCategoriesUseCase.execute());
    return "admin/indicator-form";
  }

  @GetMapping("/{id}/edit")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String editForm(@NonNull @PathVariable Long id, @NonNull Model model) {
    IndicatorResponse response = indicatorProvider.withIdResponse(id);
    SaveOrUpdateIndicatorRequest request = new SaveOrUpdateIndicatorRequest(response);
    model.addAttribute("request", request);
    model.addAttribute("categories", getAllIndicatorCategoriesUseCase.execute());
    return "admin/indicator-form";
  }

  @PostMapping("/save")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String save(
      @NonNull @Valid @ModelAttribute("request") SaveOrUpdateIndicatorRequest request,
      @NonNull BindingResult bindingResult,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    if (bindingResult.hasErrors()) {
      redirectAttributes.addFlashAttribute(
          "errorMessage",
          bindingResult.getAllErrors().getFirst().getDefaultMessage()
      );

      if (request.id() != null) {
        return "redirect:/admin/indicators/%s/edit".formatted(request.id());
      }
      return "redirect:/admin/indicators/add";
    }

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

  @PostMapping("/{id}/delete")
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
