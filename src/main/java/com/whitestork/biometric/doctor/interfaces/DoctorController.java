package com.whitestork.biometric.doctor.interfaces;

import com.whitestork.biometric.doctor.application.mapper.DoctorMapper;
import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import com.whitestork.biometric.doctor.application.usecase.DeleteDoctorUseCase;
import com.whitestork.biometric.doctor.application.usecase.GetAllDoctorsUseCase;
import com.whitestork.biometric.doctor.application.usecase.GetDoctorByIdUseCase;
import com.whitestork.biometric.doctor.application.usecase.SaveOrUpdateDoctorUseCase;
import com.whitestork.biometric.doctor.interfaces.model.SaveOrUpdateDoctorModel;
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
@RequestMapping("/admin/doctors")
public class DoctorController {
  private final GetAllDoctorsUseCase getAllDoctorsUseCase;
  private final GetDoctorByIdUseCase getDoctorByIdUseCase;
  private final SaveOrUpdateDoctorUseCase saveOrUpdateDoctorUseCase;
  private final DeleteDoctorUseCase deleteDoctorUseCase;
  private final DoctorMapper mapper;

  @ModelAttribute
  public void commonAttributes(@NonNull Model model) {
    model.addAttribute("request", new SaveOrUpdateDoctorModel());
  }

  @GetMapping
  public @NonNull String all(@NonNull Model model) {
    List<DoctorResponse> doctors = getAllDoctorsUseCase.execute();
    model.addAttribute("doctors", doctors);
    return "admin/doctors";
  }

  @GetMapping("/add")
  public String add() {
    return "admin/doctor-form";
  }

  @GetMapping("/{id}/edit")
  public @NonNull String edit(@NonNull @PathVariable Long id, @NonNull Model model) {
    DoctorResponse doctor = getDoctorByIdUseCase.execute(id);
    model.addAttribute("request", mapper.toSaveOrUpdateDoctorModel(doctor));
    return "admin/doctor-form";
  }

  @PostMapping("/save")
  public @NonNull String save(@NonNull @ModelAttribute SaveOrUpdateDoctorModel request) {
    saveOrUpdateDoctorUseCase.execute(mapper.toSaveOrUpdateDoctorRequest(request));
    return "redirect:/admin/doctors";
  }

  @DeleteMapping("/{id}")
  public @NonNull String delete(@NonNull @PathVariable Long id) {
    deleteDoctorUseCase.execute(id);
    return "redirect:/admin/doctors";
  }
}