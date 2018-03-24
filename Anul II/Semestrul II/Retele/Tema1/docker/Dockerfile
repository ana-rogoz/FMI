FROM kalilinux/kali-linux-docker

MAINTAINER Sergiu Nisioi <sergiu.nisioi@fmi.unibuc.ro>

USER root

RUN apt-get update 
RUN apt-get install -y build-essential git net-tools arp-scan nmap rtpflood python python-pip
RUN pip install scapy
RUN apt-get install -y tcpdump

RUN useradd -u 1000 -m rtuser
USER rtuser
WORKDIR /home/rtuse
USER root
