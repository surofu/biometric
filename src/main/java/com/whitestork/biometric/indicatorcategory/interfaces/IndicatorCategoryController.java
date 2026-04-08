package com.whitestork.biometric.indicatorcategory.interfaces;

import com.whitestork.biometric.indicatorcategory.application.request.SaveOrUpdateIndicatorCategoryRequest;
import com.whitestork.biometric.indicatorcategory.application.response.IndicatorCategoryResponse;
import com.whitestork.biometric.indicatorcategory.application.usecase.DeleteIndicatorCategoryByIdUseCase;
import com.whitestork.biometric.indicatorcategory.application.usecase.GetAllIndicatorCategoriesUseCase;
import com.whitestork.biometric.indicatorcategory.application.usecase.GetIndicatorCategoryByIdUseCase;
import com.whitestork.biometric.indicatorcategory.application.usecase.SaveOrUpdateIndicatorCategoryUseCase;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/indicator-categories")
public class IndicatorCategoryController {
  private final GetAllIndicatorCategoriesUseCase getAllIndicatorCategoriesUseCase;
  private final GetIndicatorCategoryByIdUseCase getIndicatorCategoryByIdUseCase;
  private final SaveOrUpdateIndicatorCategoryUseCase saveOrUpdateIndicatorCategoryUseCase;
  private final DeleteIndicatorCategoryByIdUseCase deleteIndicatorCategoryByIdUseCase;

  @GetMapping
  @PreAuthorize("isAuthenticated()")
  public @NonNull String all(@NonNull Model model) {
    List<IndicatorCategoryResponse> categories = getAllIndicatorCategoriesUseCase.execute();
    model.addAttribute("categories", categories);
    return "admin/indicator-categories";
  }

  @GetMapping("/add")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String addForm(@NonNull Model model) {
    model.addAttribute("request", new SaveOrUpdateIndicatorCategoryRequest(null, "", ""));
    return "admin/indicator-category-form";
  }

  @GetMapping("/{id}/edit")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String editForm(@NonNull @PathVariable Long id, @NonNull Model model) {
    IndicatorCategoryResponse category = getIndicatorCategoryByIdUseCase.execute(id);
    SaveOrUpdateIndicatorCategoryRequest request = new SaveOrUpdateIndicatorCategoryRequest(
        category
    );
    model.addAttribute("request", request);
    return "admin/indicator-category-form";
  }

  @PostMapping("/save")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String save(
      @NonNull @ModelAttribute("request") SaveOrUpdateIndicatorCategoryRequest request,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    try {
      IndicatorCategoryResponse saved = saveOrUpdateIndicatorCategoryUseCase.execute(request);
      redirectAttributes.addFlashAttribute("successMessage", "Категория успешно сохранена");
      return "redirect:/admin/indicator-categories/%s/edit".formatted(saved.id());
    } catch (Exception exception) {
      redirectAttributes.addFlashAttribute(
          "errorMessage",
          "Ошибка при сохранении: " + exception.getMessage()
      );

      if (request.id() != null) {
        return "redirect:/admin/indicator-categories/%s/edit".formatted(request.id());
      }
      return "redirect:/admin/indicator-categories/add";
    }
  }

  @PostMapping("/{id}/delete")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String delete(
      @NonNull @PathVariable Long id,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    try {
      deleteIndicatorCategoryByIdUseCase.execute(id);
      redirectAttributes.addFlashAttribute("successMessage", "Категория успешно удалена");
    } catch (Exception exception) {
      redirectAttributes.addFlashAttribute(
          "errorMessage",
          "Ошибка при удалении: " + exception.getMessage()
      );
    }
    return "redirect:/admin/indicator-categories";
  }
}