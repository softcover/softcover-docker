FROM phusion/baseimage:0.9.11
# https://github.com/phusion/baseimage-docker
MAINTAINER Nick Merwin <nick@softcover.io>

ENV HOME /root
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh
CMD ["/sbin/my_init"]

# ==============================================================================
# install deps
# ==============================================================================
RUN apt-get update \
  && apt-get install -y ruby gems g++ ruby-dev libcurl3 libcurl3-gnutls \
  libcurl4-openssl-dev imagemagick default-jre inkscape phantomjs \
  calibre texlive-full nodejs

# nodejs => node
RUN cd /usr/local/bin && ln -s /usr/bin/nodejs node

WORKDIR /root
# ==============================================================================
# install epubcheck
# ==============================================================================
ENV EPUB_VERSION=4.0.2

RUN curl -LO \
  https://github.com/IDPF/epubcheck/releases/download/v${EPUB_VERSION}/epubcheck-${EPUB_VERSION}.zip \
  && unzip epubcheck-${EPUB_VERSION}.zip -d bin && rm epubcheck-${EPUB_VERSION}.zip

# ==============================================================================
# install kindlegen
# ==============================================================================
RUN curl -LO \
  http://kindlegen.s3.amazonaws.com/kindlegen_linux_2.6_i386_v2_9.tar.gz \
  && tar -zxvf kindlegen_linux_2.6_i386_v2_9.tar.gz \
  && rm kindlegen_linux_2.6_i386_v2_9.tar.gz \
  && cd /usr/local/bin \
  && ln -s ~/kindlegen_linux_2.6_i386_v2_9/kindlegen kindlegen

# ==============================================================================
# softcover gem
# ==============================================================================
RUN apt-get install -y libxslt-dev libxml2-dev build-essential
RUN gem install softcover --pre --no-ri --no-rdoc

# ==============================================================================
# Health check
# ==============================================================================
RUN softcover check

# ==============================================================================
# Ready to run
# ==============================================================================
RUN mkdir /book
WORKDIR /book

EXPOSE 4000

# from book directory build html:
# $ docker run -v `pwd`:/book softcover:latest sc build:html

# run server:
# $ docker run -v `pwd`:/book -d -p 4000:4000 softcover:latest sc server
