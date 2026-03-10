# Биометрик

[![Java](https://img.shields.io/badge/Java-25%2B-orange)](https://openjdk.java.net/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-4.0.3-brightgreen)](https://spring.io/projects/spring-boot)
[![FreeMarker](https://img.shields.io/badge/FreeMarker-blue)](https://spring.io/projects/spring-boot)

**Биометрик** — веб-приложение для персонального мониторинга показателей здоровья. Оно собирает в одном месте результаты ваших измерений (глюкоза, холестерин, креатинин и другие), помогает отслеживать их динамику и вовремя замечать отклонения от нормы. Больше не нужно хранить разрозненные записи — всё под рукой в удобном и безопасном сервисе.

## Скриншоты

| Главная страница |             Список показателей             |
|:---:|:------------------------------------------:|
| ![Главная](screenshots/home.png) | ![Измерения](screenshots/measurements.png) |

|              Добавление показателя              | Аналитика |
|:-----------------------------------------------:|:---:|
| ![Добавление](screenshots/measurements_new.png) | ![Аналитика](screenshots/analytics.png) |

## Возможности

- **Учёт показателей** — добавляйте, редактируйте и удаляйте результаты анализов.
- **Аналитика** — наглядные графики с границами нормы.
- **История** — все записи группируются по датам.

## Технологии

- Java 25
- Spring Boot 4.0.3
- Spring MVC
- Spring Security
- Spring Data JDBC
- PostgreSQL
- FreeMarker
- Liquibase