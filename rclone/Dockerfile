FROM rclone/rclone:1

RUN apk add watchexec --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing

COPY ./rclone.conf /config/rclone/rclone.conf

VOLUME [ "/data" ]

ENTRYPOINT [ "watchexec", "-w", "/data", "--"]
CMD [ "rclone", "sync", "/data", "enc:/" ]
