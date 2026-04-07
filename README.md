# Biometric

[![Java](https://img.shields.io/badge/Java-25%2B-orange)](https://openjdk.java.net/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-4.0.5-brightgreen)](https://spring.io/projects/spring-boot)
[![FreeMarker](https://img.shields.io/badge/FreeMarker-blue)](https://freemarker.apache.org/)

**Biometric** is a minimalist personal health monitoring platform to record medical metrics and analyze trends. It centralizes your measurement results (glucose, cholesterol, creatinine, and more), helping you track dynamics and spot deviations from the norm early.

## Showcase

### Core Experience
| Dashboard (Home) | Measurements List | Analytics & Trends |
|:---:|:---:|:---:|
| ![Home](screenshots/home.png) | ![Measurements](screenshots/measurements.png) | ![Analytics](screenshots/analytics.png) |

### Adding Measurements (Step-by-Step)
| Step 1: Select Type | Step 2: Enter Data | Step 3: Confirmation |
|:---:|:---:|:---:|
| ![Add 1](screenshots/add-measurement-1.png) | ![Add 2](screenshots/add-measurement-2.png) | ![Add 3](screenshots/add-measurement-3.png) |

### User Profile & Security
| User Profile | Change Password | About Project |
|:---:|:---:|:---:|
| ![Profile](screenshots/profile.png) | ![Password](screenshots/change-password.png) | ![About](screenshots/about.png) |

### Authentication
| Login Page | Registration |
|:---:|:---:|
| ![Login](screenshots/login.png) | ![Register](screenshots/register.png) |

## Features

- **Comprehensive Tracking** — Log biochemistry, hormones, and vital signs.
- **Visual Analytics** — Interactive charts with reference range overlays.
- **Step-by-Step UI** — Intuitive multi-step process for adding new records.
- **Secure Access** — OAuth2 (Google) integration and robust password management.
- **Responsive Design** — Fully optimized for both desktop and mobile devices.

## Technology Stack

- **Backend:** Java 25, Spring Boot 4.0.5, Spring Security (OAuth2), Spring Data JDBC
- **Database:** PostgreSQL, Liquibase (Migrations)
- **Frontend:** FreeMarker Templates, Tailwind CSS, Vanilla JavaScript
- **Infrastructure:** Docker (Paketo Buildpacks), Maven

---
Created by [Stanislav Smirnov](https://github.com/surofu)