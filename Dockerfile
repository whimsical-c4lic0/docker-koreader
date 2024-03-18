FROM ubuntu:24.04

ARG KOREADER_DOWNLOAD_URL
ARG NON_ROOT_USER=novnc

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=600 \
    DISPLAY_HEIGHT=800

# Install dependencies
RUN apt-get update -y
RUN apt-get install -y \
  wget \
  novnc \
  supervisor \
  x11vnc \
  xvfb

# Install KOReader
RUN wget -O /tmp/koreader.deb "$KOREADER_DOWNLOAD_URL"
RUN apt-get install -y /tmp/koreader.deb
RUN rm /tmp/koreader.deb

# Redirect webroot to vnc.html instead of displaying directory listing
RUN echo "<!DOCTYPE html><html><head><meta http-equiv=\"Refresh\" content=\"0; url='vnc.html'\" /></head><body></body></html>" > /usr/share/novnc/index.html

# Copy the supervisord config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create a non-root user
RUN useradd -m $NON_ROOT_USER
RUN mkdir /docs
RUN chown $NON_ROOT_USER: /docs

WORKDIR /home/$NON_ROOT_USER
USER $NON_ROOT_USER
EXPOSE 8080
ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
