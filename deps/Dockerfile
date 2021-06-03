# --- dependencies image ---
FROM rust:latest

RUN USER=root cargo new --bin rust-playground-api

WORKDIR ./rust-playground-api

COPY ./Cargo.toml ./Cargo.toml

ADD . ./
ADD ./src ./src

RUN cargo build --release
