# Borrowed and modified example from:
# https://blog.logrocket.com/packaging-a-rust-web-service-using-docker/

# --- build image ---
FROM rust:1.43 as build

RUN USER=root cargo new --bin rust-playground-api

WORKDIR ./rust-playground-api

COPY ./Cargo.toml ./Cargo.toml

ADD . ./
ADD ./src ./src

RUN cargo build --release

RUN rm src/*.rs && \
    rm ./target/release/deps/main* && \
    rm -rf target/debug && \
    rm .gitignore && \
    rm Dockerfile && \
    rm LICENSE && \
    rm serve.sh && \
    rm start.sh && \
    rm stop.sh && \
    rm deps.sh


# --- run image ---
FROM debian:buster-slim

ARG APP=/usr/src/app

RUN apt-get update && \
    apt-get install -y ca-certificates tzdata && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8000

ENV TZ=Etc/UTC \
    APP_USER=appuser

RUN groupadd $APP_USER && \
    useradd -g $APP_USER $APP_USER && \
    mkdir -p ${APP}

COPY --from=build /rust-playground-api/target/release/main ${APP}/main

RUN chown -R $APP_USER:$APP_USER ${APP}

USER $APP_USER
WORKDIR ${APP}

CMD ["./main"]
