package com.whitestork.biometric.shared.application.component;

import com.resend.Resend;
import com.resend.core.exception.ResendException;
import com.resend.services.emails.model.CreateEmailOptions;
import lombok.extern.slf4j.Slf4j;
import org.jspecify.annotations.NonNull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class ResendEmailSender {
  private final Resend resend;
  private final String senderEmail;

  public ResendEmailSender(
      @Value("${resend.api-key}") String apiKey,
      @Value("${resend.sender-email}") String senderEmail
  ) {
    this.resend = new Resend(apiKey);
    this.senderEmail = senderEmail;
  }

  public void send(@NonNull String to, @NonNull String subject, @NonNull String htmlContent) {
    try {
      log.debug("Отправка письма на {} через Resend", to);
      CreateEmailOptions options = CreateEmailOptions.builder()
          .from(senderEmail)
          .to(to)
          .subject(subject)
          .html(wrapInTemplate(htmlContent))
          .build();
      resend.emails().send(options);
      log.debug("Письмо успешно отправлено на {}", to);
    } catch (ResendException e) {
      throw new RuntimeException("Не удалось отправить письмо на " + to, e);
    }
  }

  private @NonNull String wrapInTemplate(@NonNull String content) {
    return """
           <!DOCTYPE html>
           <html lang="ru">
           <head>
             <meta charset="UTF-8">
             <meta name="viewport" content="width=device-width,initial-scale=1">
           </head>
           <body style="margin:0;padding:0;background:#f1f5f9;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,sans-serif;">
             <table width="100%%" cellpadding="0" cellspacing="0" style="background:#f1f5f9;padding:40px 16px;">
               <tr><td align="center">
                 <table width="100%%" cellpadding="0" cellspacing="0" style="max-width:520px;">
           
                   <tr><td align="center" style="padding-bottom:24px;">
                     <span style="font-size:24px;font-weight:700;color:#059669;">Биометрик</span>
                   </td></tr>
           
                   <tr><td style="background:#ffffff;border-radius:16px;padding:40px 36px;">
                     <div style="font-size:15px;color:#374151;line-height:1.75;">
                       %s
                     </div>
                     <hr style="border:none;border-top:1px solid #e2e8f0;margin:28px 0 20px;">
                     <p style="margin:0;font-size:12px;color:#94a3b8;text-align:center;">
                       Это письмо отправлено автоматически — не отвечайте на него.
                     </p>
                   </td></tr>
           
                   <tr><td align="center" style="padding-top:20px;">
                     <p style="margin:0;font-size:12px;color:#94a3b8;">© 2026 Биометрик</p>
                   </td></tr>
           
                 </table>
               </td></tr>
             </table>
           </body>
           </html>
           """.formatted(content);
  }
}