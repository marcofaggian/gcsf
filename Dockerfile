FROM ubuntu:18.10
MAINTAINER Marco Faggian <m@marcofaggian.com>

RUN apt-get update
RUN apt install -y libfuse-dev pkg-config curl apt-utils file sudo openssl libssl-dev 
RUN curl -sSf https://static.rust-lang.org/rustup.sh | sh
RUN cargo install gcsf 

VOLUME [ "/drive" ]

CMD [ "/root/.cargo/bin/gcsf","login","gdrive"]