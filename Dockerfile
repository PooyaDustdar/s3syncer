FROM ubuntu

RUN apt update && \
    apt upgrade -y && \
    apt install -y fswatch wget
RUN wget --no-check-certificate https://dl.min.io/client/mc/release/linux-amd64/mc
RUN chmod +x mc
RUN mv mc /usr/local/bin/
RUN mc --version
COPY ./entrypoint.sh /entrypoint.sh

WORKDIR /watch
# ENV WATCH_DIR='/watch'
# ENV S3_ALIAS=""
# ENV S3_URL=""
# ENV S3_ACCESSKEY=""
# ENV S3_SECRETKEY=""
# ENV S3_BUCKET=""
CMD [ "/bin/bash", "/entrypoint.sh" ]
