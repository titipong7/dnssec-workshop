FROM ubuntu:24.04                                                                                                                                                                            

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update 
RUN apt-get -y install inetutils-ping dnsutils nano vim 

CMD ["/bin/bash", "-c", "while :; do sleep 10; done"]