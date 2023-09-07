FROM python:3.6-alpine
ARG YDCMD_VERSION
ENV PIP_ROOT_USER_ACTION=ignore
RUN apk update && \
    apk add --no-cache git && \
    pip install python-dateutil && \
    mkdir --parent /tmp/ydcmd && \
    git clone --depth 1 --branch v${YDCMD_VERSION} https://github.com/abbat/ydcmd.git /tmp/ydcmd && \
    apk del git && \
    cp /tmp/ydcmd/ydcmd.py /usr/local/bin/ydcmd && \
    rm -rf /tmp/ydcmd
ENTRYPOINT [ "/usr/local/bin/ydcmd" ]
