# Biometric

[![Java](https://img.shields.io/badge/Java-25%2B-orange)](https://openjdk.java.net/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-4.0.5-brightgreen)](https://spring.io/projects/spring-boot)
[![FreeMarker](https://img.shields.io/badge/FreeMarker-blue)](https://freemarker.apache.org/)

**Biometric** — минималистичная платформа для мониторинга личного здоровья: запись медицинских показателей и анализ динамики. Централизует результаты измерений (глюкоза, холестерин, креатинин и другие), помогая отслеживать изменения и вовремя замечать отклонения от нормы.

## Скриншоты

### Основное
| Главная | Список измерений | Аналитика |
|:---:|:---:|:---:|
| ![Home](screenshots/home.png) | ![Measurements](screenshots/measurements.png) | ![Analytics](screenshots/analytics.png) |

### Добавление измерения (пошагово)
| Шаг 1: Выбор типа |              Шаг 2: Ввод даты               |            Шаг 3: Ввод значения             |
|:---:|:-------------------------------------------:|:-------------------------------------------:|
| ![Add 1](screenshots/add-measurement-1.png) | ![Add 2](screenshots/add-measurement-2.png) | ![Add 3](screenshots/add-measurement-3.png) |

### Справочник
| Справочник | Показатели | Детали показателя |
|:---:|:---:|:---:|
| ![Reference](screenshots/reference.png) | ![Indicators](screenshots/reference-indicators.png) | ![Indicator Details](screenshots/reference-indicator-details.png) |

| Детали категории | Детали профессии | Детали врача |
|:---:|:---:|:---:|
| ![Category Details](screenshots/reference-indicator-category-details.png) | ![Profession Details](screenshots/reference-profession-details.png) | ![Doctor Details](screenshots/reference-doctors-details.png) |

### Профиль и безопасность
| Профиль | Смена пароля | О приложении |
|:---:|:---:|:---:|
| ![Profile](screenshots/profile.png) | ![Password](screenshots/change-password.png) | ![About](screenshots/about.png) |

### Аутентификация
| Вход | Регистрация |
|:---:|:---:|
| ![Login](screenshots/login.png) | ![Register](screenshots/register.png) |

## Возможности

- **Комплексный учёт** — ведение биохимии, гормонов и жизненных показателей.
- **Визуальная аналитика** — интерактивные графики с отображением референсных значений.
- **Пошаговый интерфейс** — удобный многошаговый процесс добавления записей.
- **Справочник** — просмотр показателей и профессий с нормами и описаниями.
- **Безопасный доступ** — интеграция OAuth2 (Google) и управление паролем.
- **Адаптивный дизайн** — полная оптимизация для десктопа и мобильных устройств.

## Технологии

- **Бэкенд:** Java 25, Spring Boot 4.0.5, Spring Security (OAuth2), Spring Data JDBC
- **База данных:** PostgreSQL, Flyway
- **Фронтенд:** FreeMarker, Tailwind CSS, Vanilla JavaScript
- **Инфраструктура:** Docker (Paketo Buildpacks), Maven

---
Создано [Stanislav Smirnov](https://github.com/surofu)