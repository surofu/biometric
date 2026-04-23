# ---- Stage 1: Build (Java & Frontend) ----
FROM eclipse-temurin:25-jdk-alpine AS builder

RUN apk add --no-cache nodejs npm

ARG APP_HOME=/app
WORKDIR ${APP_HOME}

COPY package.json package-lock.json* ./
RUN npm install

COPY tailwind.config.js postcss.config.js ./
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

RUN chmod +x mvnw
RUN ./mvnw dependency:go-offline -B

COPY src src

ENV NODE_ENV=production
RUN npx postcss src/main/resources/css/style.css -o src/main/resources/static/css/style.css --minify

RUN ./mvnw clean package -DskipTests -Dexec.skip=true
RUN java -Djarmode=layertools -jar target/*.jar extract --destination extracted

# ---- Stage 2: Runtime ----
FROM eclipse-temurin:25-jre-alpine

RUN apk add --no-cache wget

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

ENV SPRING_PROFILES_ACTIVE=prod \
    DB_HOST=db \
    DB_PORT=5432 \
    DB_NAME=biometric

HEALTHCHECK --interval=30s --timeout=3s --start-period=30s --retries=3 \
    CMD wget --quiet --tries=1 --spider http://localhost:8080/actuator/health || exit 1

EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java ${JAVA_OPTS} org.springframework.boot.loader.launch.JarLauncher"]