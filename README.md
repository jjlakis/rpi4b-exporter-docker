# rpi4b-exporter-docker
Raspberry Pi 4B Node-exporter with vcgecmd metrics based on ubuntu docker image


## Run it
docker build .
docker run -d -v /dev:/dev --privileged --net=host <image-hash>

## Try it
curl localhost:9100/metrics
