FROM netsyos/base:latest

RUN apt-get update
#RUN apt-get -y install transmission-daemon
#RUN apt-get -y install python git
#
#RUN git clone --depth 1 https://github.com/RuudBurger/CouchPotatoServer.git /opt/couchpotato
#RUN mkdir /etc/couchpotato
#RUN mkdir /var/couchpotato
#RUN useradd --system --user-group --no-create-home couchpotato
#RUN chown -R couchpotato:couchpotato /opt/couchpotato
#RUN chown -R couchpotato:couchpotato /etc/couchpotato
#RUN chown -R couchpotato:couchpotato /var/couchpotato
#
##RUN echo 'net.core.rmem_max = 16777216' >> /etc/sysctl.conf
##RUN echo 'net.core.wmem_max = 4194304' >> /etc/sysctl.conf
#COPY config/default/* /etc/default/
#
#RUN mkdir /etc/service/transmission
#ADD service/transmission.sh /etc/service/transmission/run
#RUN chmod +x /etc/service/transmission/run
#
#RUN mkdir /etc/service/couchpotato
#ADD service/couchpotato.sh /etc/service/couchpotato/run
#RUN chmod +x /etc/service/couchpotato/run
#
#RUN mkdir /etc/service/logs
#ADD service/logs.sh /etc/service/logs/run
#RUN chmod +x /etc/service/logs/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
