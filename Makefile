.PHONY: clean clippy lint fmt all release debug

all: release debug
debug: target/debug/librubyfmt.a
release: target/release/librubyfmt.a

target/c_main_debug: main.c target/debug/librubyfmt.a
	clang -O3 main.c target/debug/librubyfmt.a -framework Foundation -lgmp -o $@

target/c_main_release: main.c target/release/librubyfmt.a
	clang -O3 main.c target/release/librubyfmt.a -framework Foundation -lgmp -o $@

target/release/librubyfmt.a: librubyfmt/src/*.rs librubyfmt/Cargo.toml
	mkdir -p target/release
	cd librubyfmt && cargo build --release
	cp librubyfmt/target/release/librubyfmt.a $@

target/debug/librubyfmt.a: librubyfmt/src/*.rs librubyfmt/Cargo.toml
	mkdir -p target/debug
	cd librubyfmt && cargo build
	cp librubyfmt/target/debug/librubyfmt.a $@

lint: clippy
	./script/lints/lint_fixtures.sh
	./script/lints/lint_scripts.sh
	./script/lints/lint_rust.sh

clean:
	rm -rf target/

fmt:
	cargo fmt
	cd librubyfmt && cargo fmt && git add -u ./

clippy:
	cargo clippy && cd librubyfmt && cargo clippy
