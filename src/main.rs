/* Borrowed and modified example from:
   https://blog.logrocket.com/packaging-a-rust-web-service-using-docker/
*/

use warp::{Filter, Rejection, Reply};

type Result<T> = std::result::Result<T, Rejection>;

#[tokio::main]
async fn main() {
    let health_route = warp::path!("health").and_then(health_handler);

    let routes = health_route.with(warp::cors().allow_any_origin());

    println!("Started server at: http://localhost:8080");
    warp::serve(routes).run(([0, 0, 0, 0], 8080)).await;
}

async fn health_handler() -> Result<impl Reply> {
    Ok("OK")
}
