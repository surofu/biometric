package com.whitestork.biometric.shared.infrastructure.config;

import com.whitestork.biometric.shared.application.component.DateFormatter;
import com.whitestork.biometric.shared.application.component.SecurityService;
import freemarker.template.TemplateModelException;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

@Configuration
@RequiredArgsConstructor
public class FreemarkerConfig {
  private final FreeMarkerConfigurer freeMarkerConfigurer;
  private final DateFormatter dateFormatter;
  private final SecurityService securityService;

  @PostConstruct
  public void setSharedVariables() throws TemplateModelException {
    freeMarkerConfigurer.getConfiguration().setSharedVariable("dateFormatter", dateFormatter);
    freeMarkerConfigurer.getConfiguration().setSharedVariable("auth", securityService);
  }
}
