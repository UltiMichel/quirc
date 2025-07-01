#!/bin/bash
set -e

# Quirc build script
# This script builds the Debian package for the specified architecture

echo "Starting build..."

# Get architecture from environment variable
ARCH=${ARCH:-arm64}

echo "Building quirc for architecture: ${ARCH}"

# Validate architecture
case ${ARCH} in
    arm64|armhf)
        echo "Building for supported architecture: ${ARCH}"
        ;;
    *)
        echo "Unsupported architecture: ${ARCH}"
        echo "Supported architectures: arm64, armhf"
        exit 1
        ;;
esac

# Create a writable workspace in /tmp
BUILD_DIR="/tmp/quirc-build"
echo "Creating writable build directory: ${BUILD_DIR}"
rm -rf ${BUILD_DIR}
cp -r /src ${BUILD_DIR}
cd ${BUILD_DIR}

# Build the package
echo "Building Debian package for ${ARCH}..."
dpkg-buildpackage -a${ARCH} -Pcross -uc -us -b

# Copy built packages to output directory
echo "Copying build artifacts to /output..."
mkdir -p /output
cp ../*.deb /output/ 2>/dev/null || true
cp ../*.changes /output/ 2>/dev/null || true
cp ../*.buildinfo /output/ 2>/dev/null || true

echo "Build completed successfully!"
echo "Available packages in /output/:"
ls -la /output/