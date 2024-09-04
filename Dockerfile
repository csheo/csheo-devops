# Stage 1: Build stage
ARG AWS_ACCOUNT_ID
FROM ${AWS_ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/amazoncorretto:21-alpine as builder

WORKDIR build

ARG AWS_ACCOUNT_ID
# 컨테이너 외부에서 사용
ARG JAR_FILE=./build/libs/*.jar
ARG APP_JAR=app.jar
COPY ${JAR_FILE} ${APP_JAR}

# 필요 패키지 설치
RUN apk add --no-cache tzdata bash curl && \
    cp /usr/share/zoneinfo/Asia/Seoul /etc/localtime && \
    echo "Asia/Seoul" > /etc/timezone

# 환경 변수 설정 (컨테이너 내부)
ENV TZ=Asia/Seoul
ENV LANG=ko_KR.UTF-8
ENV LANGUAGE=ko_KR:ko;en_US:en
ENV LC_ALL=ko_KR.UTF-8

# JAR 파일 추출
RUN java -Djarmode=tools -jar ${APP_JAR} extract --layers --launcher


# Stage 2: Final stage
FROM ${AWS_ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/amazoncorretto:21-alpine
WORKDIR build/app

COPY --from=builder /usr/share/zoneinfo/Asia/Seoul /etc/localtime
COPY --from=builder /etc/timezone /etc/timezone

# 빌드 스테이지에서 추출된 파일들을 복사
COPY --from=builder /build/app/dependencies/ ./
COPY --from=builder /build/app/snapshot-dependencies/ ./
COPY --from=builder /build/app/spring-boot-loader/ ./
COPY --from=builder /build/app/application/ ./

# 포트 설정
EXPOSE 8080

# 엔트리포인트 설정
ENTRYPOINT ["java", "org.springframework.boot.loader.launch.JarLauncher"]
