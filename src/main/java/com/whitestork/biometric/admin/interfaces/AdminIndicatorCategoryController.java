package com.whitestork.biometric.admin.interfaces;

import com.whitestork.biometric.admin.interfaces.model.SaveOrUpdateIndicatorCategoryModel;
import com.whitestork.biometric.indicatorcategory.application.mapper.IndicatorCategoryMapper;
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
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/indicator-categories")
public class AdminIndicatorCategoryController {
  private final GetAllIndicatorCategoriesUseCase getAllIndicatorCategoriesUseCase;
  private final GetIndicatorCategoryByIdUseCase getIndicatorCategoryByIdUseCase;
  private final SaveOrUpdateIndicatorCategoryUseCase saveOrUpdateIndicatorCategoryUseCase;
  private final DeleteIndicatorCategoryByIdUseCase deleteIndicatorCategoryByIdUseCase;
  private final IndicatorCategoryMapper mapper;

  @ModelAttribute
  public void commonAttributes(Model model) {
    model.addAttribute("request", new SaveOrUpdateIndicatorCategoryModel());
  }

  @GetMapping
  @PreAuthorize("isAuthenticated()")
  public @NonNull String all(@NonNull Model model) {
    List<IndicatorCategoryResponse> categories = getAllIndicatorCategoriesUseCase.execute();
    model.addAttribute("categories", categories);
    return "admin/indicator-categories";
  }

  @GetMapping("/add")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String add() {
    return "admin/indicator-category-form";
  }

  @GetMapping("/{id}/edit")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String edit(@NonNull @PathVariable Long id, @NonNull Model model) {
    model.addAttribute(
        "request",
        mapper.toSaveOrUpdateModel(getIndicatorCategoryByIdUseCase.execute(id))
    );
    return "admin/indicator-category-form";
  }

  @PostMapping("/save")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String save(
      @NonNull @ModelAttribute("request") SaveOrUpdateIndicatorCategoryRequest request,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    saveOrUpdateIndicatorCategoryUseCase.execute(request);
    redirectAttributes.addFlashAttribute("successMessage", "Категория успешно сохранена");
    return "redirect:/admin/indicator-categories";
  }

  @DeleteMapping("/{id}")
  @PreAuthorize("isAuthenticated()")
  public @NonNull String delete(
      @NonNull @PathVariable Long id,
      @NonNull RedirectAttributes redirectAttributes
  ) {
    deleteIndicatorCategoryByIdUseCase.execute(id);
    redirectAttributes.addFlashAttribute("successMessage", "Категория успешно удалена");
    return "redirect:/admin/indicator-categories";
  }
}