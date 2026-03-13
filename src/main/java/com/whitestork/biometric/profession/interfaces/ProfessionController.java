package com.whitestork.biometric.profession.interfaces;

import com.whitestork.biometric.profession.application.response.ProfessionResponse;
import com.whitestork.biometric.profession.application.usecase.GetAllProfessionsUseCase;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/professions")
public class ProfessionController {
  private final GetAllProfessionsUseCase getAllProfessionsUseCase;

  @GetMapping
  @PreAuthorize("isAuthenticated()")
  public @NonNull String professions(@NonNull Model model) {
    List<ProfessionResponse> professions = getAllProfessionsUseCase.execute();
    model.addAttribute("professions", professions);
    return "admin/professions";
  }
}
