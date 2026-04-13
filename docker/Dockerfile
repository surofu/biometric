# ---- Stage 1: Build ----
FROM eclipse-temurin:25-jdk-alpine AS builder

RUN apk add --no-cache nodejs npm

WORKDIR /app

COPY package.json package-lock.json* ./
RUN npm ci

# Копируем конфиги и Maven
COPY tailwind.config.js ./
COPY postcss.config.js ./
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Кешируем зависимости Maven
RUN ./mvnw dependency:go-offline -B

# Копируем исходники
COPY src src

# Генерируем CSS (сначала фронт!)
RUN npm run build:prod

# Собираем JAR (теперь готовый CSS уже лежит в static и попадет в билд)
RUN ./mvnw clean package -DskipTests

# Распаковываем на слои
RUN java -Djarmode=layertools -jar target/*.jar extract --destination extracted

# ---- Stage 2: Runtime ----
FROM eclipse-temurin:25-jre-alpine

RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

WORKDIR /app

COPY --from=builder --chown=spring:spring /app/extracted/dependencies/ ./
COPY --from=builder --chown=spring:spring /app/extracted/spring-boot-loader/ ./
COPY --from=builder --chown=spring:spring /app/extracted/snapshot-dependencies/ ./
COPY --from=builder --chown=spring:spring /app/extracted/application/ ./

ENV JAVA_OPTS="-XX:+UseCompactObjectHeaders \
    -XX:+UseG1GC \
    -XX:+UseStringDeduplication \
    -XX:MaxRAMPercentage=75 \
    -XX:+ExitOnOutOfMemoryError \
    -XX:+HeapDumpOnOutOfMemoryError \
    -XX:HeapDumpPath=/tmp/heapdump.hprof"

ENV SERVER_PORT=8088
ENV SPRING_PROFILES_ACTIVE=prod

EXPOSE 8088

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} org.springframework.boot.loader.launch.JarLauncher"]