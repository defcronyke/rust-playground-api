# Rust Playground API

[![sponsor the project](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&link=https://github.com/sponsors/defcronyke)](https://github.com/sponsors/defcronyke) [![github-pipeline](https://github.com/defcronyke/rust-playground-api/workflows/github-pipeline/badge.svg)](https://github.com/defcronyke/rust-playground-api/actions) [![pipeline status](https://gitlab.com/defcronyke/rust-playground-api/badges/master/pipeline.svg)](https://gitlab.com/defcronyke/rust-playground-api/-/pipelines)

---

v0.1.0 - 2021 by `Jeremy Carter <jeremy@jeremycarter.ca>`

GitLab: [https://gitlab.com/defcronyke/rust-playground-api](https://gitlab.com/defcronyke/rust-playground-api)  
GitHub: [https://github.com/defcronyke/rust-playground-api](https://github.com/defcronyke/rust-playground-api)

---

Run some Rust code online. Get the program's output, as well as assembly and WebAssembly, as a JSON response.

---

## Automated builds from the master branch

### Release Binary

- [Linux x86_64 (GitLab mirror)](https://gitlab.com/defcronyke/rust-playground-api/-/jobs/artifacts/master/download?job=release-linux-x86_64)
- [Linux x86_64 (GitHub mirror)](https://tinyurl.com/github-artifact?repo=defcronyke/rust-playground-api&file=rust-playground-api-release-linux-x86_64)

### Debug Binary

- [Linux x86_64 Debug (GitLab mirror)](https://gitlab.com/defcronyke/rust-playground-api/-/jobs/artifacts/master/download?job=debug-linux-x86_64)
- [Linux x86_64 Debug (GitHub mirror)](https://tinyurl.com/github-artifact?repo=defcronyke/rust-playground-api&file=rust-playground-api-debug-linux-x86_64)

NOTE: After downloading and extracting from the GitHub mirror, you need to run the following commands because GitHub Actions isn't preserving the correct permissions for the files:

```shell
cd rust-playground-api && chmod 755 *
```

---

## (Optional) Clone the source code with git

```shell
git clone https://github.com/defcronyke/rust-playground-api.git && \
cd rust-playground-api
```

---

## Run the program

- Automated build version:

  ```shell
  ./rust-playground-api
  ```

- Git source version:

  ```shell
  ./serve.sh
  ```

---

## Usage

1. Make a GitHub `secret` or `public` Gist, with your desired `Rust` program code in it:
   [https://gist.github.com](https://gist.github.com)

2. Get the Gist's ID from its URL, for example the `id` value as below:
   https://gist.github.com/{username}/{id}

3. Run the `Rust` code by using the `id` in your GET request, for example:
   [http://localhost:8080/?id=1ea016619193533f9ac6cd1d8ae22d58](http://localhost:8080/?id=1ea016619193533f9ac6cd1d8ae22d58)

---

## API routes available

_Use your desired "GitHub Gist ID" for the `id` GET query parameter in the example requests below. The `Rust` code in that Gist will be used for
the query._

- Run the code:
  GET /?id=1ea016619193533f9ac6cd1d8ae22d58 [http://localhost:8080/?id=1ea016619193533f9ac6cd1d8ae22d58](http://localhost:8080/?id=1ea016619193533f9ac6cd1d8ae22d58)

- Run the test suite:
  GET /test?id=1ea016619193533f9ac6cd1d8ae22d58 [http://localhost:8080/test?id=1ea016619193533f9ac6cd1d8ae22d58](http://localhost:8080/test?id=1ea016619193533f9ac6cd1d8ae22d58)

- Build the code:
  GET /build?id=1ea016619193533f9ac6cd1d8ae22d58 [http://localhost:8080/build?id=1ea016619193533f9ac6cd1d8ae22d58](http://localhost:8080/build?id=1ea016619193533f9ac6cd1d8ae22d58)

- Build and output WebAssembly of the code:
  GET /wasm?id=1ea016619193533f9ac6cd1d8ae22d58 [http://localhost:8080/wasm?id=1ea016619193533f9ac6cd1d8ae22d58](http://localhost:8080/wasm?id=1ea016619193533f9ac6cd1d8ae22d58)

- Build and output Assembly of the code:
  GET /asm?id=1ea016619193533f9ac6cd1d8ae22d58 [http://localhost:8080/asm?id=1ea016619193533f9ac6cd1d8ae22d58](http://localhost:8080/asm?id=1ea016619193533f9ac6cd1d8ae22d58)

---

## Build and run the Docker container

- Build the dependencies image:

  ```shell
  ./deps.sh
  ```

- Build the production image:

  ```shell
  ./prod.sh
  ```

- Run the Docker container:

  ```shell
  ./start.sh
  ```

- Stop the Docker container when finished:

  ```shell
  ./stop.sh
  ```
