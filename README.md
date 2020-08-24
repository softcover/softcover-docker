# Softcover Dockerfile

For running the [Softcover](https://github.com/softcover/softcover) eBook typesetting system.

Image hosted on [DockerHub](https://hub.docker.com/r/softcover/softcover).


## Usage

The first step is to download the docker image using the commend:
```bash
docker pull softcover/softcover
```
Note this step takes a long time since we it downloads more than 3GB of files
(a complete LaTeX distribution, Inkscape, and a complete Ruby dev environment).


Build html from book directory:
```bash
docker run -v `pwd`:/book softcover/softcover:latest sc build:html
```

Run softcover interactive server:
```bash
docker run -v `pwd`:/book -d -p 4000:4000 softcover/softcover:latest sc server
```
then open the URL http://localhost:4000/your-book-name.html in your browser.



## Interactive shell

To run bash inside the container use the following command:
```bash
docker run -ti -v `pwd`:/book -p 4000:4000 softcover/softcover:latest /bin/bash
```
The current working directory is mounted as `/book`.



## Local docker image build

As an alternative to `docker pull` command above, you can build the docker image
locally from the provided `Dockerfile`. To build the docker image, run the command
```bash
docker build -t softcover .
```
This step takes a fairly long time since it downloads a complete TeX distribution
and other system packages required to run Softcover. Time to go get lunch!

After the docker build step is done, you can run all the commands shown above,
by replacing the argument `softcover/softcover:latest` with `softcover` (local tag).
