FROM ubuntu/bind9:9.18-22.04_beta                                                                                                                                                                           

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update 
RUN apt-get -y install inetutils-ping dnsutils nano vim 

CMD ["/bin/bash", "-c", "while :; do sleep 10; done"]