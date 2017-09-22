FROM netsyos/base:latest


# global environment settings
ENV DEBIAN_FRONTEND="noninteractive" \
PLEX_DOWNLOAD="https://downloads.plex.tv/plex-media-server" \
PLEX_INSTALL="https://plex.tv/downloads/latest/1?channel=8&build=linux-ubuntu-x86_64&distro=ubuntu" \
PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/config/Library/Application Support" \
PLEX_MEDIA_SERVER_HOME="/usr/lib/plexmediaserver" \
PLEX_MEDIA_SERVER_INFO_DEVICE=docker \
PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS="6" \
PLEX_MEDIA_SERVER_USER=plex

RUN useradd -ms /bin/bash plex

RUN apt-get update

# install packages
RUN apt-get install -y \
	avahi-daemon \
	unrar

# install plex
RUN curl -o \
	/tmp/plexmediaserver.deb -L \
	"${PLEX_INSTALL}" && \
 dpkg -i /tmp/plexmediaserver.deb && \

# change abc home folder to fix plex hanging at runtime with usermod
 usermod -d /app plex

# cleanup
RUN rm -rf /etc/default/plexmediaserver

# add local files
COPY root/ /

RUN mkdir /etc/service/plex
ADD service/plex.sh /etc/service/plex/run
RUN chmod +x /etc/service/plex/run

RUN mkdir /etc/service/avahi
ADD service/avahi.sh /etc/service/avahi/run
RUN chmod +x /etc/service/avahi/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# ports and volumes
EXPOSE 32400 32400/udp 32469 32469/udp 5353/udp 1900/udp
VOLUME /config /transcode