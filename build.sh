#!/bin/bash

docker build -f Dockerfile.alpine -t ghcr.io/fullaxx/novnc:alpine .

docker build -f Dockerfile.bullseye -t ghcr.io/fullaxx/novnc:bullseye .
docker build -f Dockerfile.bookworm -t ghcr.io/fullaxx/novnc:bookworm .
docker build -f Dockerfile.trixie -t ghcr.io/fullaxx/novnc:trixie .

docker build -f Dockerfile.focal -t ghcr.io/fullaxx/novnc:focal .
docker build -f Dockerfile.jammy -t ghcr.io/fullaxx/novnc:jammy .
docker build -f Dockerfile.noble -t ghcr.io/fullaxx/novnc:noble .

docker tag ghcr.io/fullaxx/novnc:noble ghcr.io/fullaxx/novnc:latest
