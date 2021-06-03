#!/bin/bash

curl -sL -H 'Content-Type: application/json' -X POST -d '{"channel":"nightly","mode":"debug","edition":"2018","crateType":"lib","tests":false,"code":"fn main() {\n    println!(\"Hello, world!\");\n}","backtrace":false}' -H 'Referrer: https://play.rust-lang.org/?version=nightly&mode=debug&edition=2018&code=fn%20main()%20%7B%0A%20%20%20%20println!(%22Hello%2C%20world!%22)%3B%0A%7D' https://play.rust-lang.org/execute

