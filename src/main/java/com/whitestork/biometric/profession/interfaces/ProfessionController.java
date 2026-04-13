package com.whitestork.biometric.profession.interfaces;

import com.whitestork.biometric.doctor.application.usecase.GetAllDoctorsUseCase;
import com.whitestork.biometric.profession.application.mapper.ProfessionMapper;
import com.whitestork.biometric.profession.application.response.ProfessionDetailsResponse;
import com.whitestork.biometric.profession.application.response.ProfessionResponse;
import com.whitestork.biometric.profession.application.usecase.DeleteProfessionUseCase;
import com.whitestork.biometric.profession.application.usecase.GetAllProfessionsUseCase;
import com.whitestork.biometric.profession.application.usecase.GetProfessionByIdUseCase;
import com.whitestork.biometric.profession.application.usecase.SaveOrUpdateProfessionUseCase;
import com.whitestork.biometric.profession.interfaces.model.SaveOrUpdateProfessionModel;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/professions")
public class ProfessionController {
  private final GetAllProfessionsUseCase getAllProfessionsUseCase;
  private final GetProfessionByIdUseCase getProfessionByIdUseCase;
  private final SaveOrUpdateProfessionUseCase saveOrUpdateProfessionUseCase;
  private final DeleteProfessionUseCase deleteProfessionUseCase;
  private final ProfessionMapper mapper;
  private final GetAllDoctorsUseCase getAllDoctorsUseCase;

  @ModelAttribute
  public void commonAttributes(@NonNull Model model) {
    model.addAttribute("request", new SaveOrUpdateProfessionModel());
  }

  @GetMapping
  public @NonNull String all(@NonNull Model model) {
    List<ProfessionResponse> professions = getAllProfessionsUseCase.execute();
    model.addAttribute("professions", professions);
    return "admin/professions";
  }

  @GetMapping("/add")
  public String add() {
    return "admin/profession-form";
  }

  @GetMapping("/{id}/edit")
  public @NonNull String edit(@NonNull @PathVariable Long id, @NonNull Model model) {
    ProfessionDetailsResponse profession = getProfessionByIdUseCase.execute(id);
    model.addAttribute("profession", profession);
    model.addAttribute("allDoctors", getAllDoctorsUseCase.execute());
    model.addAttribute("request", mapper.toModel(profession));
    return "admin/profession-form";
  }

  @PostMapping("/save")
  public @NonNull String save(@NonNull @ModelAttribute SaveOrUpdateProfessionModel request) {
    saveOrUpdateProfessionUseCase.execute(mapper.toRequest(request));
    return "redirect:/admin/professions";
  }

  @DeleteMapping("/{id}")
  public @NonNull String delete(@NonNull @PathVariable Long id) {
    deleteProfessionUseCase.execute(id);
    return "redirect:/admin/professions";
  }
}