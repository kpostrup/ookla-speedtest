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

# Commented out by default, this setting allows you to limit access to your OoklaServer.
# The default allows all domains, but remove the comment to only allow access from
# Ookla.com, Speedtest.net, and any other domain added to the list.
RUN echo "OoklaServer.allowedDomains = *.ookla.com, *.speedtest.net" > OoklaServer.properties

USER speedtest

CMD ./OoklaServer

EXPOSE 5060 8080
