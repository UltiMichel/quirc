FROM debian:bookworm

# Add ARM64 and ARMHF architectures
RUN dpkg --add-architecture arm64 && \
    dpkg --add-architecture armhf

# Install base development tools and cross-compilation dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    debhelper \
    devscripts \
    fakeroot \
    pkg-config \
    libjpeg-dev \
    libpng-dev \
    gcc-aarch64-linux-gnu \
    g++-aarch64-linux-gnu \
    gcc-arm-linux-gnueabihf \
    g++-arm-linux-gnueabihf \
    crossbuild-essential-arm64 \
    crossbuild-essential-armhf \
    libjpeg-dev:arm64 \
    libjpeg-dev:armhf \
    libpng-dev:arm64 \
    libpng-dev:armhf \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /src

# Copy the source code
COPY . /src/

# Make build script executable
RUN chmod +x /src/build.sh

# Default command
CMD ["./build.sh", "arm64"]
