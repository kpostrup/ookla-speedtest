FROM alpine:latest

MAINTAINER Kenneth Østrup

WORKDIR /opt/ookla

RUN addgroup -S speedtest && \
    adduser -S -G speedtest speedtest

RUN apk update && \
    apk add ca-certificates wget && \
    update-ca-certificates

# See: http://www.ookla.com/support/a26325856prise/
RUN wget http://install.speedtest.net/ooklaserver/ooklaserver.sh
RUN chmod a+x ooklaserver.sh
RUN ./ooklaserver.sh install -f

USER speedtest

CMD ./OoklaServer

EXPOSE 5060 8080
