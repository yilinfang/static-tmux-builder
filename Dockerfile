FROM alpine:3.20

# Install build dependencies
RUN apk add --no-cache \
    build-base \
    autoconf \
    automake \
    libtool \
    bison \
    pkgconf \
    curl \
    tar \
    ncurses-dev \
    ncurses-static \
    libevent-dev \
    libevent-static

# Set working directory
WORKDIR /src

# Set tmux version
ENV TMUX_VERSION="3.5a"

# Download specific tmux release
RUN curl -L -o tmux-${TMUX_VERSION}.tar.gz https://github.com/tmux/tmux/releases/download/${TMUX_VERSION}/tmux-${TMUX_VERSION}.tar.gz && \
    tar -xzf tmux-${TMUX_VERSION}.tar.gz

# Build tmux statically with musl
RUN cd tmux-${TMUX_VERSION} && \
    LDFLAGS="-static" ./configure --enable-static && \
    make -j$(nproc)

# Strip the binary to reduce size
RUN strip tmux-${TMUX_VERSION}/tmux

# Create a directory for the final binary
RUN mkdir -p /output && \
    cp tmux-${TMUX_VERSION}/tmux /output/ && \
    chmod +x /output/tmux

# Set the entrypoint to copy the binary to a mounted volume
ENTRYPOINT ["cp", "/output/tmux", "/build/"]

