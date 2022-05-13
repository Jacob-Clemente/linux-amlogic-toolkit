# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y libblkid-dev

## Add source code to the build stage.
ADD . /linux-amlogic-toolkit
WORKDIR /linux-amlogic-toolkit

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN ./bin/build

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /linux-amlogic-toolkit/bin/abootimg /
