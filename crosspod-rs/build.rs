use cxx_build;

fn main() {
    cxx_build::bridge("src/crosspod.rs").compile("crosspod")
}

