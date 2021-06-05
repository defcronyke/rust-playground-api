# --- build image ---
FROM rust_playground_api_deps:latest as build

ARG APP=/usr/src/app

ENV TZ=Etc/UTC \
    APP_USER=appuser

WORKDIR ./rust-playground-api

COPY ./Cargo.toml ./Cargo.toml

ADD . ./
ADD ./src ./src

RUN cargo build --release

RUN rm src/*.rs || true; \
    rm ./target/release/deps/main* || true; \
    rm -rf target/debug || true; \
    rm -rf deps || true; \
    rm .gitignore || true; \
    rm Dockerfile || true; \
    rm LICENSE || true; \
    rm serve.sh || true; \
    rm start.sh || true; \
    rm stop.sh || true; \
    rm deps.sh || true


# --- run image ---
FROM debian:buster-slim

ARG APP=/usr/src/app

RUN apt-get update && \
    apt-get install -y ca-certificates tzdata curl jq && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 8000

ENV TZ=Etc/UTC \
    APP_USER=appuser

RUN groupadd $APP_USER && \
    useradd -g $APP_USER $APP_USER && \
    mkdir -p ${APP}

COPY --from=build /rust-playground-api/target/release/main ${APP}/main
COPY --from=build /rust-playground-api/gist.sh ${APP}/
COPY --from=build /rust-playground-api/asm-gist.sh ${APP}/
COPY --from=build /rust-playground-api/build-gist.sh ${APP}/
COPY --from=build /rust-playground-api/run-gist.sh ${APP}/
COPY --from=build /rust-playground-api/test-gist.sh ${APP}/
COPY --from=build /rust-playground-api/wasm-gist.sh ${APP}/
COPY --from=build /rust-playground-api/src/example1/main.rs ${APP}/src/example1/main.rs

RUN chown -R $APP_USER:$APP_USER ${APP}

USER $APP_USER
WORKDIR ${APP}

CMD ["./main"]
