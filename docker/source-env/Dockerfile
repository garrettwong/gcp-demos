FROM debian:stable-slim
LABEL MAINTAINER="Garrett Wong <garrettwong@google.com>"

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

# setup workdir
RUN mkdir -p /root/garrettwong
WORKDIR /root/garrettwong
COPY . .

ENV ENVIRONMENT "TEST"
ENV APP "APP"

CMD echo "$APP:$ENVIRONMENT"
