FROM ubuntu:bionic

MAINTAINER Kenneth Østrup

WORKDIR /opt/ookla

RUN groupadd -g 999 speedtest && \
    useradd -r -u 999 -g speedtest speedtest

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y wget

# See: http://www.ookla.com/support/a26325856prise/
RUN wget -q https://install.speedtest.net/ooklaserver/ooklaserver.sh
RUN chmod a+x ooklaserver.sh
RUN ./ooklaserver.sh install -f

USER speedtest

CMD ./OoklaServer

EXPOSE 5060 8080
