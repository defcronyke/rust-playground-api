# Rust Playground API

[![sponsor the project](https://img.shields.io/static/v1?label=Sponsor&message=%E2%9D%A4&logo=GitHub&link=https://github.com/sponsors/defcronyke)](https://github.com/sponsors/defcronyke) [![github-pipeline](https://github.com/defcronyke/rust-playground-api/workflows/github-pipeline/badge.svg)](https://github.com/defcronyke/rust-playground-api/actions)

---

v0.0.1 - "Hello, world! version" - 2021 by `Jeremy Carter <jeremy@jeremycarter.ca>`

GitLab: [https://gitlab.com/defcronyke/rust-playground-api](https://gitlab.com/defcronyke/rust-playground-api)  
GitHub: [https://github.com/defcronyke/rust-playground-api](https://github.com/defcronyke/rust-playground-api)

---

Run some Rust code online. Get the program's output, as well as assembly and WebAssembly, as a JSON response.

---

## Automated builds from the master branch

- [Linux x86_64 (GitHub mirror)](https://tinyurl.com/github-artifact?repo=defcronyke/rust-playground-api&file=rust-playground-api-release-linux-x86_64)

- [Linux x86_64 Debug (GitHub mirror)](https://tinyurl.com/github-artifact?repo=defcronyke/rust-playground-api&file=rust-playground-api-debug-linux-x86_64)

NOTE: After downloading and extracting from the GitHub mirror, you need to run the following commands because GitHub Actions isn't preserving the correct permissions for the files:

```shell
cd rust-playground-api && chmod 755 *
```

---

## API routes available

- Run the code: GET /run [http://localhost:8080](http://localhost:8080)

- Run the test suite: GET /test [http://localhost:8080/test](http://localhost:8080/test)

- Build the code: GET /build [http://localhost:8080/build](http://localhost:8080/build)

- Build and output WebAssembly of the code: GET /wasm [http://localhost:8080/wasm](http://localhost:8080/wasm)

- Build and output Assembly of the code: GET /asm [http://localhost:8080/asm](http://localhost:8080/asm)
