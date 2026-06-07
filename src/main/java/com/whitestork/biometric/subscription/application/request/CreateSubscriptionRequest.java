package com.whitestork.biometric.subscription.application.request;

public record CreateSubscriptionRequest(

//    @NotNull(message = "Не указан план подписки")
    Long planId,

    // Данные карты — используются только для тестовой имитации оплаты
//    @NotBlank(message = "Введите имя владельца карты")
//    @Size(max = 100, message = "Имя слишком длинное")
    String cardHolder,

//    @NotBlank(message = "Введите номер карты")
//    @Pattern(regexp = "\\d{16}", message = "Номер карты должен содержать 16 цифр")
    String cardNumber,

//    @NotBlank(message = "Введите срок действия")
//    @Pattern(regexp = "(0[1-9]|1[0-2])/\\d{2}", message = "Формат: ММ/ГГ")
    String expiryDate,

//    @NotBlank(message = "Введите CVV")
//    @Pattern(regexp = "\\d{3}", message = "CVV должен содержать 3 цифры")
    String cvv
) {
}