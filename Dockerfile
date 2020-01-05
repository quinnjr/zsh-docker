# Copyright (c) 2019 Joseph R. Quinn <quinn.josephr@protonmail.com>
# SPDX-License-Identifier: ISC

FROM alpine:latest AS builder

WORKDIR /tmp/build

ARG VERSION
ARG VERSION_LATEST
ARG MACHINE_HARDWARE="x86_64"
ENV ZSH_VERSION "zsh $VERSION ($MACHINE_HARDWARE-pc-linux-musl)"

COPY repositories /etc/apk/repositories

RUN apk update && \
  apk add --no-cache --upgrade \
    binutils \
    autoconf \
    libtool \
    libcap-dev \
    ncurses5-widec-libs \
    ncurses-dev \
    pcre-dev \
    groff \
    texinfo \
    gdbm \
    clang-dev \
    curl \
    musl-utils \
    musl-dev \
    make \
    git \
    gcc
    
RUN if [[ "$VERSION" == "$VERSION_LATEST" && ! -f "./$VERSION.tar.xz" ]]; then \
  curl -L "https://www.zsh.org/pub/zsh-$VERSION.tar.xz" | tar -xJ --strip=1 && \
  curl -L "https://www.zsh.org/pub/zsh-$VERSION-doc.tar.xz" | tar -xJ --strip=1; \
  else curl -L "https://www.zsh.org/pub/old/zsh-$VERSION.tar.xz" | tar xJ --strip=1 && \
  curl -L "https://www.zsh.org/pub/old/zsh-$VERSION-doc.tar.xz" | tar xJ --strip=1; fi

RUN ./Util/preconfig

RUN CC=/usr/bin/clang PM=$(nproc) CFLAGS="-std=gnu11 -mtune=generic -O2 -pipe $CFLAGS" \
  MAKEFLAGS="-j$(nproc) $MAKEFLAGS" \
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --mandir=/usr/share/man \
    --infodir=/usr/share/info \
    --docdir=/usr/share/doc/zsh \
  	--htmldir=/usr/share/doc/zsh/html \
  	--enable-etcdir=/etc/zsh \
  	--enable-zshenv=/etc/zsh/zshenv \
  	--enable-zlogin=/etc/zsh/zlogin \
  	--enable-zlogout=/etc/zsh/zlogout \
  	--enable-zprofile=/etc/zsh/zprofile \
  	--enable-zshrc=/etc/zsh/zshrc \
    --bindir=/usr/bin \
    --with-term-lib='ncursesw' \
    --enable-fndir=/usr/share/zsh/functions \
  	--enable-scriptdir=/usr/share/zsh/scripts \
    --enable-pcre \
    --enable-cap \
    --enable-multibyte \
    --with-tcsetpgrp \
    --enable-zsh-secure-free

RUN mkdir -p /tmp/install && \
  make DESTDIR=/tmp/install install && \
  install -Dm644 LICENCE "/tmp/install/usr/share/licenses/zsh/LICENSE" && \
  /usr/bin/strip --strip-debug --strip-unneeded "/tmp/install/usr/bin/zsh"

COPY zprofile /tmp/install/etc/zsh/

FROM scratch

LABEL maintainer="https://github.com/quinnjr/zsh-docker"
# LABEL contributors=""

WORKDIR /

COPY --from=builder /tmp/install /

VOLUME [ "/etc/zsh", "/usr/share/zsh/functions", "/usr/share/zsh/scripts" ]

ENTRYPOINT ["/usr/bin/zsh"]

CMD ["-l"]