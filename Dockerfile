FROM lsiobase/alpine:3.11
MAINTAINER Marco Faggian <m@marcofaggian.com>

# set version label
ARG BUILD_DATE
ARG VERSION
LABEL build_version="marcofaggian/gcsf version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="aptalca"

RUN \
 echo "**** install packages ****" && \
 apk add --no-cache \
	curl \
	findutils \
  fuse-dev \
  file \
  libressl-dev \
  pkg \
	jq \
	openssl \
	p7zip \
	python \
	rsync \
	tar \
	transmission-cli \
	transmission-daemon \
	unrar \
	unzip && \
 echo "**** install third party themes ****" && \
 curl -o \
	/tmp/combustion.zip -L \
	"https://github.com/Secretmapper/combustion/archive/release.zip" && \
 unzip \
	/tmp/combustion.zip -d \
	/ && \
 mkdir -p /tmp/twctemp && \
 TWCVERSION=$(curl -sX GET "https://api.github.com/repos/ronggang/transmission-web-control/releases/latest" \
	| awk '/tag_name/{print $4;exit}' FS='[""]') && \
 curl -o \
	/tmp/twc.tar.gz -L \
	"https://github.com/ronggang/transmission-web-control/archive/${TWCVERSION}.tar.gz" && \
 tar xf \
	/tmp/twc.tar.gz -C \
	/tmp/twctemp --strip-components=1 && \
 mv /tmp/twctemp/src /transmission-web-control && \
 mkdir -p /kettu && \
 curl -o \
	/tmp/kettu.tar.gz -L \
	"https://github.com/endor/kettu/archive/master.tar.gz" && \
 tar xf \
	/tmp/kettu.tar.gz -C \
	/kettu --strip-components=1 && \
 echo "**** cleanup ****" && \
 rm -rf \
	/tmp/* &&
 curl https://sh.rustup.rs -sSf | sh && \
  cargo install gcsf 

# copy local files
COPY root/ /

VOLUME /config /downloads /watch

# ports and volumes
EXPOSE 8081 9091 51413

CMD [ "/.cargo/bin/gcsf","login","gdrive"]
