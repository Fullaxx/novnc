# An Ubuntu docker image running noVNC

## Base Docker Image
[Ubuntu](https://hub.docker.com/_/ubuntu) 24.04 (x64)

## Get the image from Docker Hub or build it locally
```
docker pull ghcr.io/fullaxx/novnc
docker build -t="ghcr.io/fullaxx/novnc" github.com/Fullaxx/novnc
```

## Run the image (using fullaxx/ubuntu-desktop as working example)
noVNC will listen on port 8080 inside the container. \
Run the image on 172.17.0.1, pointing to VNC server at 172.17.0.1:5901
```
docker run -d --rm -p 172.17.0.1:5901:5901 fullaxx/ubuntu-desktop
docker run -d -e VNCADDR=172.17.0.1:5901 -p 172.17.0.1:80:8080 ghcr.io/fullaxx/novnc
Browse to http://172.17.0.1:80/
```
Run the image using an SSL cert called novnc.pem found in /tmp/cert \
Make sure to volume mount the certificate in /cert
```
docker run -d --rm -p 172.17.0.1:5901:5901 fullaxx/ubuntu-desktop
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
