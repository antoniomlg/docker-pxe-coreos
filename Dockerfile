FROM ubuntu:16.04
MAINTAINER Antonio Manuel López González <antonio@arte-consultores.com>

EXPOSE 80

ENV URL localhot

RUN  apt-get update && apt-get install -y tftpd-hpa inetutils-inetd isc-dhcp-server wget


WORKDIR /etc/default
COPY config-files/tftpd-hpa tftpd-hpa

WORKDIR /etc
COPY config-files/inetd.conf inetd.conf
RUN service tftpd-hpa restart

WORKDIR /var/lib/tftpboot
RUN wget https://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe.vmlinuz \
    && wget https://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe.vmlinuz.sig \
    && wget https://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe_image.cpio.gz \
    && wget https://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe_image.cpio.gz.sig

# RUN gpg --verify coreos_production_pxe.vmlinuz.sig
# RUN gpg --verify coreos_production_pxe_image.cpio.gz.sig


RUN mkdir /var/lib/tftpboot/pxelinux.cfg
WORKDIR /var/lib/tftpboot/pxelinux.cfg
COPY config-files/default default


#WORKDIR /
#COPY config-files/docker-entrypoint.sh docker-entrypoint.sh
#RUN chmod +x /docker-entrypoint.sh

# ENTRYPOINT ["/docker-entrypoint.sh"]
