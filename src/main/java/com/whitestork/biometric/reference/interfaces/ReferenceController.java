package com.whitestork.biometric.reference.interfaces;

import com.whitestork.biometric.doctor.application.response.DoctorDetailsResponse;
import com.whitestork.biometric.doctor.application.usecase.GetAllDoctorsUseCase;
import com.whitestork.biometric.doctor.application.usecase.GetDoctorByIdUseCase;
import com.whitestork.biometric.indicator.application.usecase.GetAllIndicatorsUseCase;
import com.whitestork.biometric.indicator.application.usecase.GetIndicatorByIdUseCase;
import com.whitestork.biometric.indicatorcategory.application.usecase.GetAllIndicatorCategoriesUseCase;
import com.whitestork.biometric.profession.application.usecase.GetAllProfessionsUseCase;
import com.whitestork.biometric.profession.application.usecase.GetProfessionByIdUseCase;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/reference")
@RequiredArgsConstructor
public class ReferenceController {
  private final GetAllIndicatorsUseCase getAllIndicatorsUseCase;
  private final GetAllIndicatorCategoriesUseCase getAllIndicatorCategoriesUseCase;
  private final GetAllDoctorsUseCase getAllDoctorsUseCase;
  private final GetAllProfessionsUseCase getAllProfessionsUseCase;
  private final GetIndicatorByIdUseCase getIndicatorByIdUseCase;
  private final GetDoctorByIdUseCase getDoctorByIdUseCase;
  private final GetProfessionByIdUseCase getProfessionByIdUseCase;

  @GetMapping
  public @NonNull String all() {
    return "reference/all";
  }

  @GetMapping("/indicators")
  public @NonNull String indicators(@NonNull Model model) {
    model.addAttribute("categories", getAllIndicatorCategoriesUseCase.execute());
    model.addAttribute("indicators", getAllIndicatorsUseCase.execute());
    return "reference/indicators";
  }

  @GetMapping("/indicators/{id}")
  public @NonNull String indicatorDetails(@NonNull @PathVariable Long id, @NonNull Model model) {
    model.addAttribute("indicator", getIndicatorByIdUseCase.execute(id));
    return "reference/indicator-details";
  }

  @GetMapping("/indicator-categories")
  public @NonNull String indicatorCategories(@NonNull Model model) {
    model.addAttribute("categories", getAllIndicatorCategoriesUseCase.execute());
    return "reference/indicator-categories";
  }

  @GetMapping("/indicator-categories/{id}")
  public @NonNull String indicatorCategoriesDetails(
      @NonNull @PathVariable Long id,
      @NonNull Model model
  ) {
    model.addAttribute("category", getIndicatorByIdUseCase.execute(id));
    return "reference/category-details";
  }

  @GetMapping("/doctors")
  public @NonNull String doctors(@NonNull Model model) {
    model.addAttribute("doctors", getAllDoctorsUseCase.execute());
    return "reference/doctors";
  }

  @GetMapping("/doctors/{id}")
  public @NonNull String doctorDetails(@NonNull @PathVariable Long id, @NonNull Model model) {
    DoctorDetailsResponse doctor = getDoctorByIdUseCase.execute(id);
    System.out.println(doctor.getDescription());
    model.addAttribute("doctor", doctor);
    return "reference/doctor-details";
  }

  @GetMapping("/professions")
  public @NonNull String professions(@NonNull Model model) {
    model.addAttribute("professions", getAllProfessionsUseCase.execute());
    return "reference/professions";
  }

  @GetMapping("/professions/{id}")
  public @NonNull String professionDetails(
      @NonNull @PathVariable Long id,
      @NonNull Model model
  ) {
    model.addAttribute("profession", getProfessionByIdUseCase.execute(id));
    return "reference/profession-details";
  }
}
