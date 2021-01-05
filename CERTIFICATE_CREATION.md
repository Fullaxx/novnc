# HOW TO CREATE AN SSL CERTIFICATE

## SSL Certificate Creation Example
Launch an Ubuntu docker container:
```
mkdir -p /tmp/cert
docker run -it --rm -v /tmp/cert:/cert ubuntu:latest
```
Inside the container we are going to create our certificate:
```
apt-get update
apt-get install -y openssl
cd /cert
openssl req -newkey rsa:2048 -nodes -keyout novnc.pem -x509 -days 365 -out novnc.pem
# You can add -subj to make this a non-interactive process
# -subj "/C=US/ST=New York/L=Brooklyn/O=Example Brooklyn Company/CN=examplebrooklyn.com"
logout
```
Now you can use novnc.pem (located in /tmp/cert) inside your novnc container
