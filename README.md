# Softcover Dockerfile

For running the [Softcover](https://github.com/softcover/softcover) eBook typesetting system.

Image hosted on [DockerHub](https://hub.docker.com/r/softcover/softcover).

## Usage:

Build html from book directory:
```bash
docker run -v `pwd`:/book softcover:latest sc build:html
```

Run server:
```bash
docker run -v `pwd`:/book -d -p 4000:4000 softcover:latest sc server
```
