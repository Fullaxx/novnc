# HOW TO CREATE AN SSL CERTIFICATE

## SSL Certificate Creation Example
Launch an Ubuntu docker container:
```
docker run -it --rm -v /tmp/cert:/cert ubuntu:latest
```
Inside the container we are going to create our certificate:
```
apt-get update
apt-get install -y openssl
cd /cert
openssl req -x509 -nodes -newkey rsa:2048 -keyout novnc.pem -out novnc.pem -days 365
logout
```
Now you can use novnc.pem (located in /tmp/cert) inside your novnc container
