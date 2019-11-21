FROM alpine

RUN apk add curl && \
  curl -O https://downloads.rclone.org/rclone-current-linux-amd64.zip && \
  unzip rclone-current-linux-amd64.zip && \
  cd rclone-*-linux-amd64 && \
  cp rclone /usr/bin/ && \
  chmod 755 /usr/bin/rclone && \
  apk add watchexec --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

WORKDIR /app

COPY ./rclone.conf /secrets/rclone.conf

VOLUME [ "/data" ]

ENTRYPOINT [ "watchexec", "-w", "/data", "--"]
CMD [ "rclone", "--config", "/secrets/rclone.conf", "sync", "/data", "enc:/" ]
