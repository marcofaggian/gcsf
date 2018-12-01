FROM ubuntu:18.10
MAINTAINER Marco Faggian <m@marcofaggian.com>

RUN apt-get update \
  && apt install -y libfuse-dev pkg-config curl apt-utils file sudo openssl libssl-dev \ 
  && curl -sSf https://static.rust-lang.org/rustup.sh | sh \
  && cargo install gcsf \
  export PATH=$PATH:$HOME/.cargo/bin

VOLUME [ "/drive" ]

EXPOSE 8081

ENTRYPOINT ["$HOME/.cargo/bin"]