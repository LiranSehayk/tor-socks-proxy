FROM alpine:3.11

LABEL maintainer="Peter Dave Hello <hsu@peterdavehello.org>"
LABEL name="tor-socks-proxy"
LABEL version="latest"

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk -U upgrade && \
    apk -v add tor@edge curl && \
    chmod 700 /var/lib/tor && \
    rm -rf /var/cache/apk/* && \
    tor --version
COPY torrc /etc/tor/

ARG PORT=9150 
ARG tor_interval=30
RUN sed -i "s/\$PORT/$PORT/g" /etc/tor/torrc && \
    echo "MaxCircuitDirtiness 50 >> /etc/tor/torrc


HEALTHCHECK --timeout=10s --start-period=60s \
    CMD curl --fail --socks5-hostname localhost:$PORT -I -L 'https://www.facebookcorewwwi.onion/' || exit 1

EXPOSE $PORT

CMD ["/usr/bin/tor", "-f", "/etc/tor/torrc"]
