# A docker image running noVNC

## Supported Images
All images are built for x64 (linux/amd64) from the official [Alpine](https://hub.docker.com/_/alpine), [Debian](https://hub.docker.com/_/debian) and [Ubuntu](https://hub.docker.com/_/ubuntu) base images.

| Tag | OS (base image) | noVNC | websockify | Distro security support |
|-----|-----------------|-------|------------|-------------------------|
| `alpine` | Alpine Linux, latest stable (`alpine:latest`) | 1.6.0 | 0.13.0 | follows Alpine releases |
| `trixie`, `latest` | Debian 13 (`debian:trixie`) | 1.6.0 | 0.12.0 | until Jun 2030 |
| `bookworm` | Debian 12 (`debian:bookworm`) | 1.3.0 | 0.10.0 | until Jun 2028 |
| `resolute` | Ubuntu 26.04 LTS (`ubuntu:resolute`) | 1.6.0 | 0.13.0 | until May 2031 |
| `noble` | Ubuntu 24.04 LTS (`ubuntu:noble`) | 1.3.0 | 0.10.0 | until May 2029 |
| `jammy` | Ubuntu 22.04 LTS (`ubuntu:jammy`) | 1.0.0 | 0.10.0 | until Jun 2027 |
| `focal` | Ubuntu 20.04 LTS (`ubuntu:focal`) | 1.0.0 | 0.9.0 | ended May 2025 |

noVNC and websockify are the versions packaged by each distro. The `alpine` tag follows `alpine:latest` (3.24 as of Nov 2026), so its versions move with new Alpine releases. \
Support dates are from [endoflife.date](https://endoflife.date): end of LTS for Debian, end of standard support for Ubuntu.

`bullseye` (Debian 11) is no longer built because its LTS ended in Aug 2026; its Dockerfile now lives in `obsolete/`. The last published `ghcr.io/fullaxx/novnc:bullseye` image stays available but won't receive updates.

## Pull the images or Build them locally
### Alpine Images
```
docker pull ghcr.io/fullaxx/novnc:alpine
```
### Debian Images
```
docker pull ghcr.io/fullaxx/novnc:trixie
docker pull ghcr.io/fullaxx/novnc:bookworm
```
### Ubuntu Images
```
docker pull ghcr.io/fullaxx/novnc:resolute
docker pull ghcr.io/fullaxx/novnc:noble
docker pull ghcr.io/fullaxx/novnc:jammy
docker pull ghcr.io/fullaxx/novnc:focal
```
### Build locally
```
docker build -f Dockerfile.alpine   -t ghcr.io/fullaxx/novnc:alpine .
docker build -f Dockerfile.resolute -t ghcr.io/fullaxx/novnc:resolute .
docker build -f Dockerfile.noble    -t ghcr.io/fullaxx/novnc:noble .
docker build -f Dockerfile.jammy    -t ghcr.io/fullaxx/novnc:jammy .
docker build -f Dockerfile.focal    -t ghcr.io/fullaxx/novnc:focal .
docker build -f Dockerfile.trixie   -t ghcr.io/fullaxx/novnc:trixie .
docker build -f Dockerfile.bookworm -t ghcr.io/fullaxx/novnc:bookworm .
```

## Run the image (using ubuntu-desktop as working example)
noVNC will listen on port 8080 inside the container. \
Run the image on 172.17.0.1, pointing to VNC server at 172.17.0.1:5901
```
docker run -d --rm -p 172.17.0.1:5901:5901 ghcr.io/fullaxx/ubuntu-desktop
docker run -d -e VNCADDR=172.17.0.1:5901 -p 172.17.0.1:80:8080 ghcr.io/fullaxx/novnc
Browse to http://172.17.0.1:80/
```
Run the image using an SSL cert called novnc.pem found in /tmp/cert \
Make sure to volume mount the certificate in /cert
```
docker run -d --rm -p 172.17.0.1:5901:5901 ghcr.io/fullaxx/ubuntu-desktop
docker run -d -e VNCADDR=172.17.0.1:5901 -p 172.17.0.1:80:8080 -e CERTFILE=novnc.pem -v /tmp/cert:/cert ghcr.io/fullaxx/novnc
Browse to https://172.17.0.1:80/
```

## Quick note on using localhost
In the above example we used the IP address of the docker0 interface (172.17.0.1) \
This was done intentionally. You can substitute any IP address that is not localhost (127.0.0.1) \
If you were to take the above example and replace 172.17.0.1 with 127.0.0.1 it would likely not work \
because the localhost of the vnc server is not reachable from inside the novnc container. \
You can use --network=host to avoid this issue, or bind to any non-localhost IP address.

## Create a self-signed certificate
For a quick example on SSL certificate creation, [go here](https://github.com/Fullaxx/novnc/blob/master/CERTIFICATE_CREATION.md)

## Posting Issues on Github
When posting issues, please provide the following:
* docker run line used to create the novnc container and the vnc server container
* output from docker logs
* screenshot showing the issue if not described in logs
* any other relevant networking information
