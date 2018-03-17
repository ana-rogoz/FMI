FROM kalilinux/kali-linux-docker

MAINTAINER Sergiu Nisioi <sergiu.nisioi@fmi.unibuc.ro>

USER root

RUN apt-get update 
RUN apt-get install -y build-essential git net-tools arp-scan nmap rtpflood python python-pip
RUN pip install scapy
RUN apt-get install -y tcpdump
# move tcpdump from the default location to /usr/local
RUN mv /usr/sbin/tcpdump /usr/local/bin
# add the new location to the PATH in case it's not there
ENV PATH="/usr/local/bin:${PATH}"

RUN useradd -u 1000 -m rtuser
USER rtuser
WORKDIR /home/rtuser
