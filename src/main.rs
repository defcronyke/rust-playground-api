use serde::Serialize;
use std::env;
use std::error::Error;
use std::net::IpAddr;
use std::process::Command;
use warp::http::header::{HeaderMap, HeaderValue};
use warp::http::StatusCode;
use warp::reject::Rejection;
use warp::{reject, Filter, Reply};
use warp_real_ip::real_ip;

type Result<T> = std::result::Result<T, Rejection>;

#[derive(Debug, Serialize)]
struct ErrorMessage {
    code: u16,
    message: String,
}

impl reject::Reject for ErrorMessage {}

#[derive(Debug)]
struct DivideByZero;

impl reject::Reject for DivideByZero {}

async fn health_handler(addr: String) -> Result<impl Reply> {
    println!("|info| GET /health | from: {}", addr);

    Ok("{\"code\": 200, \"message\": \"200 OK\"}")
}

async fn asm_handler(addr: String) -> Result<impl Reply> {
    println!("|info| GET /asm | from: {}", addr);

    let output = Command::new("/bin/bash")
        .arg("-c")
        .arg("./asm.sh")
        .output()
        .expect("failed to execute process");

    let stdout = String::from_utf8_lossy(&output.stdout).to_string();

    println!("status: {}", output.status);
    println!("stderr: {}", String::from_utf8_lossy(&output.stderr));

    Ok(stdout)
}

async fn build_handler(addr: String) -> Result<impl Reply> {
    println!("|info| GET /build | from: {}", addr);

    let output = Command::new("/bin/bash")
        .arg("-c")
        .arg("./build.sh")
        .output()
        .expect("failed to execute process");

    let stdout = String::from_utf8_lossy(&output.stdout).to_string();

    println!("status: {}", output.status);
    println!("stderr: {}", String::from_utf8_lossy(&output.stderr));

    Ok(stdout)
}

async fn run_handler(addr: String) -> Result<impl Reply> {
    println!("|info| GET / (or GET /run) | from: {}", addr);

    let output = Command::new("/bin/bash")
        .arg("-c")
        .arg("./run.sh")
        .output()
        .expect("failed to execute process");

    let stdout = String::from_utf8_lossy(&output.stdout).to_string();

    println!("status: {}", output.status);
    println!("stderr: {}", String::from_utf8_lossy(&output.stderr));

    Ok(stdout)
}

async fn test_handler(addr: String) -> Result<impl Reply> {
    println!("|info| GET /test | from: {}", addr);

    let output = Command::new("/bin/bash")
        .arg("-c")
        .arg("./test.sh")
        .output()
        .expect("failed to execute process");

    let stdout = String::from_utf8_lossy(&output.stdout).to_string();

    println!("status: {}", output.status);
    println!("stderr: {}", String::from_utf8_lossy(&output.stderr));

    Ok(stdout)
}

async fn wasm_handler(addr: String) -> Result<impl Reply> {
    println!("|info| GET /wasm | from: {}", addr);

    let output = Command::new("/bin/bash")
        .arg("-c")
        .arg("./wasm.sh")
        .output()
        .expect("failed to execute process");

    let stdout = String::from_utf8_lossy(&output.stdout).to_string();

    println!("status: {}", output.status);
    println!("stderr: {}", String::from_utf8_lossy(&output.stderr));

    Ok(stdout)
}

async fn rejection_handler(err: Rejection) -> Result<impl Reply> {
    let code;
    let message;

    if err.is_not_found() {
        code = StatusCode::NOT_FOUND;
        message = "404 Not Found";
    } else if let Some(DivideByZero) = err.find() {
        code = StatusCode::BAD_REQUEST;
        message = "400 Bad Request";
    } else if let Some(e) = err.find::<warp::filters::body::BodyDeserializeError>() {
        message = match e.source() {
            Some(cause) => {
                if cause.to_string().contains("denom") {
                    "400 Bad Request"
                } else {
                    "400 Bad Request"
                }
            }
            None => "400 Bad Request",
        };
        code = StatusCode::BAD_REQUEST;
    } else if let Some(_) = err.find::<warp::reject::MethodNotAllowed>() {
        code = StatusCode::METHOD_NOT_ALLOWED;
        message = "405 Method Not Allowed";
    } else {
        eprintln!("unhandled rejection: {:?}", err);
        code = StatusCode::INTERNAL_SERVER_ERROR;
        message = "500 Internal Server Error";
    }

    let json = warp::reply::json(&ErrorMessage {
        code: code.as_u16(),
        message: message.into(),
    });

    Ok(warp::reply::with_status(json, code))
}

#[tokio::main]
async fn main() {
    let port_default: u16 = 8080;

    let port: u16 = {
        env::var("PORT")
            .unwrap_or(format!("{}", port_default))
            .parse()
            .unwrap_or(port_default)
    };

    let proxy_addr = [127, 0, 0, 1].into();

    let mut res_headers = HeaderMap::new();
    res_headers.insert(
        "Content-Type",
        HeaderValue::from_static("application/json; charset=utf-8"),
    );

    let health_route = warp::path!("health").and(
        real_ip(vec![proxy_addr])
            .map(|addr: Option<IpAddr>| format!("{:?}", addr.unwrap()))
            .and_then(health_handler),
    );

    let asm_route = warp::path!("asm").and(
        real_ip(vec![proxy_addr])
            .map(|addr: Option<IpAddr>| format!("{:?}", addr.unwrap()))
            .and_then(asm_handler),
    );

    let build_route = warp::path!("build").and(
        real_ip(vec![proxy_addr])
            .map(|addr: Option<IpAddr>| format!("{:?}", addr.unwrap()))
            .and_then(build_handler),
    );

    let run_route = warp::path!("run").and(
        real_ip(vec![proxy_addr])
            .map(|addr: Option<IpAddr>| format!("{:?}", addr.unwrap()))
            .and_then(run_handler),
    );

    let test_route = warp::path!("test").and(
        real_ip(vec![proxy_addr])
            .map(|addr: Option<IpAddr>| format!("{:?}", addr.unwrap()))
            .and_then(test_handler),
    );

    let wasm_route = warp::path!("wasm").and(
        real_ip(vec![proxy_addr])
            .map(|addr: Option<IpAddr>| format!("{:?}", addr.unwrap()))
            .and_then(wasm_handler),
    );

    let index_route = warp::path::end().and(
        real_ip(vec![proxy_addr])
            .map(|addr: Option<IpAddr>| format!("{:?}", addr.unwrap()))
            .and_then(run_handler),
    );

    let routes = warp::any().and(
        warp::get()
            .and(
                health_route
                    .or(asm_route)
                    .or(build_route)
                    .or(run_route)
                    .or(test_route)
                    .or(wasm_route)
                    .or(index_route)
                    .recover(rejection_handler)
                    .with(warp::reply::with::headers(res_headers.clone()))
                    .with(warp::cors().allow_any_origin()),
            )
            .recover(rejection_handler)
            .with(warp::reply::with::headers(res_headers.clone()))
            .with(warp::cors().allow_any_origin()),
    );

    println!("Started server at: http://localhost:{}", port);

    warp::serve(routes).run(([0, 0, 0, 0], port)).await;
}
