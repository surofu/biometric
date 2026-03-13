package com.whitestork.biometric.doctor.interfaces;

import com.whitestork.biometric.doctor.application.response.DoctorResponse;
import com.whitestork.biometric.doctor.application.usecase.GetAllDoctorsUseCase;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequiredArgsConstructor
@RequestMapping("/admin/doctors")
public class DoctorController {
  private final GetAllDoctorsUseCase getAllDoctorsUseCase;

  @GetMapping
  public @NonNull String doctors(@NonNull Model model) {
    List<DoctorResponse> doctors = getAllDoctorsUseCase.execute();
    model.addAttribute("doctors", doctors);
    return "admin/doctors";
  }
}
