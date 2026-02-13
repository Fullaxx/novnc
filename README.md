# A docker image running noVNC

## Base Docker Image
[Alpine](https://hub.docker.com/_/alpine) (x64)
[Debian](https://hub.docker.com/_/debian) (x64)
[Ubuntu](https://hub.docker.com/_/ubuntu) (x64)

## Pull the images or Build them locally
### Ubuntu Images
```
docker pull ghcr.io/fullaxx/novnc:noble
docker pull ghcr.io/fullaxx/novnc:jammy
docker pull ghcr.io/fullaxx/novnc:focal
```
### Alpine Images
```
docker pull ghcr.io/fullaxx/novnc:alpine
```
### Debian Images
```
docker pull ghcr.io/fullaxx/novnc:trixie
docker pull ghcr.io/fullaxx/novnc:bookworm
docker pull ghcr.io/fullaxx/novnc:bullseye
```
### Build locally
```
docker build -f Dockerfile.alpine   -t ghcr.io/fullaxx/novnc:alpine .
docker build -f Dockerfile.noble    -t ghcr.io/fullaxx/novnc:noble .
docker build -f Dockerfile.jammy    -t ghcr.io/fullaxx/novnc:jammy .
docker build -f Dockerfile.focal    -t ghcr.io/fullaxx/novnc:focal .
docker build -f Dockerfile.trixie   -t ghcr.io/fullaxx/novnc:trixie .
docker build -f Dockerfile.bookworm -t ghcr.io/fullaxx/novnc:bookworm .
docker build -f Dockerfile.bullseye -t ghcr.io/fullaxx/novnc:bullseye .
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
