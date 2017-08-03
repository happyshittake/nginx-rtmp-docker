FROM debian:stable-slim
MAINTAINER happyshittake<happyshittake@gmail.com>

RUN apt-get update && apt-get install -y \
    git \
    gcc \
    make \
    libpcre3-dev \
    zlib1g-dev \
    libssl-dev && \
    rm -r /var/lib/apt/lists/*

COPY ./nginx /build/nginx
COPY ./nginx-rtmp-module /build/nginx-rtmp-module
WORKDIR "/build/nginx"

RUN ./auto/configure --with-http_ssl_module --add-module=/build/nginx-rtmp-module
RUN make
RUN make install

RUN apt-get remove -y git gcc make && apt-get autoremove -y

WORKDIR "/"

RUN rm -rf /build/nginx
RUN rm -rf /build /nginx-rtmp-module

COPY ./nginx.conf /usr/local/nginx/conf/nginx.conf

EXPOSE 1935

ENTRYPOINT ["/usr/local/nginx/sbin/nginx"]





