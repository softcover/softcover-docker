# Softcover Docker Image

For running the [softcover.io](https://www.softcover.io) latex build system.

https://hub.docker.com/repository/docker/softcover/softcover

## Usage:

Build html from book directory:
```bash
docker run -v `pwd`:/book softcover:latest sc build:html
```

Run server:
```bash
docker run -v `pwd`:/book -d -p 4000:4000 softcover:latest sc server
```
