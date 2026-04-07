package com.whitestork.biometric.shared.infrastructure.config;

import com.whitestork.biometric.shared.application.service.DateFormatter;
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

  @PostConstruct
  public void setSharedVariables() throws TemplateModelException {
    freeMarkerConfigurer.getConfiguration().setSharedVariable("dateFormatter", dateFormatter);
  }
}
