# List available commands
default:
  just --list

# Auto format code
lint-fix:
  cargo fmt
[private]
ci-lint-rustfmt:
  cargo fmt --check

alias l := lint
# Lint code
lint:
  cargo clippy
[private]
ci-lint-clippy: ci-build-deps
  RUSTFLAGS="-Dwarnings" just lint

alias la := lint-all
# Common lint
lint-all: lint-fix lint

alias b := build
# Build all rust crates
build:
  cargo build
[private]
ci-build-deps:
  sudo apt-get update
  sudo apt-get install -y --no-install-recommends libkrb5-dev krb5-multidev
[private]
ci-build: ci-build-deps
  RUSTFLAGS="-Dwarnings" just build
