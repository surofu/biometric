package com.whitestork.biometric.user.application.usecase;

import com.whitestork.biometric.shared.application.component.ResendEmailSender;
import com.whitestork.biometric.user.application.component.EmailVerificationTokenDeleter;
import com.whitestork.biometric.user.application.component.EmailVerificationTokenSaver;
import com.whitestork.biometric.user.domain.EmailVerificationToken;
import com.whitestork.biometric.user.domain.User;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.jspecify.annotations.NonNull;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SendVerificationEmailUseCase {
  private final EmailVerificationTokenDeleter deleter;
  private final EmailVerificationTokenSaver saver;
  private final ResendEmailSender emailSender;

  @Value("${app.base-url}")
  private String baseUrl;

  public void execute(@NonNull User user) {
    deleter.deleteWithUserId(user.savedId());
    String token = UUID.randomUUID().toString();
    saver.save(new EmailVerificationToken(user.savedId(), token));
    String link = "%s/verify-email?token=%s".formatted(baseUrl, token);

    emailSender.send(
        user.email(),
        "Подтвердите вашу почту — Биометрик",
        """
            <p style="margin:0 0 8px 0;font-size:20px;font-weight:600;color:#111827;">Подтвердите почту</p>
            <p style="margin:0 0 24px 0;color:#6b7280;">Здравствуйте! Для завершения регистрации нажмите кнопку ниже.</p>

            <div style="text-align:center;margin:28px 0;">
              <a href="%s"
                 style="display:inline-block;background:#10b981;color:#ffffff;text-decoration:none;font-weight:600;font-size:15px;padding:13px 36px;border-radius:8px;letter-spacing:0.01em;">
                Подтвердить почту
              </a>
            </div>

            <p style="margin:24px 0 4px 0;font-size:13px;color:#9ca3af;text-align:center;">
              Или перейдите по ссылке:
            </p>
            <p style="margin:0;font-size:12px;text-align:center;word-break:break-all;">
              <a href="%s" style="color:#059669;">%s</a>
            </p>

            <p style="margin:24px 0 0 0;font-size:13px;color:#9ca3af;text-align:center;">
              Ссылка действительна 24 часа. Если вы не регистрировались — просто проигнорируйте это письмо.
            </p>
            """.formatted(link, link, link)
    );
  }
}