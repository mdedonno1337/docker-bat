FROM rust

RUN apt-get update && \
    apt-get install -y cmake pkg-config clang

RUN git clone https://github.com/sharkdp/bat.git /tmp/bat

WORKDIR /tmp/bat

RUN git checkout tags/$(git describe --tags $(git rev-list --tags --max-count=1)) -b latest

RUN RUSTFLAGS='-C link-arg=-s' cargo install bat

