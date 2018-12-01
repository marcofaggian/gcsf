FROM ubuntu:18.10
MAINTAINER Marco Faggian <m@marcofaggian.com>

ENV DRIVE_PATH "/drive"

RUN apt-get update && apt upgrade -y && apt install -y libfuse-dev pkg-config curl apt-utils file sudo openssl libssl-dev

RUN curl -sSf https://static.rust-lang.org/rustup.sh | sh

RUN cargo install gcsf

RUN export PATH=$PATH:$HOME/.cargo/bin

VOLUME [ "/drive" ]

EXPOSE 8081

ENTRYPOINT ["$HOME/.cargo/bin"]