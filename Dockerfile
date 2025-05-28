FROM alpine:3.21

ARG PACKAGES=" \
    xvfb xvfb-run \
    xdotool \
    wine \
    shadow \
    gnutls \
    bash \
    inotify-tools \
    python3 py3-pip \
    "

#
# Install wine and a few dependencies
#

RUN apk update && \
    apk add $PACKAGES && \
    pip install --break-system-packages fastapi uvicorn

#
# Create novetus user.
#

RUN useradd \
      -u 1000 -U \
      -d /home/novetus \
      -s /bin/bash novetus && \
    mkdir -p /home/novetus && \
    chown -R novetus:novetus /home/novetus && \
    usermod -G users novetus

#
# Setup wineprefix.
#

USER novetus

RUN export WINEPREFIX=/home/novetus/.wine && \
    WINEDLLOVERRIDES="mscoree,mshtml=" wineboot -u && \
    xvfb-run wine msiexec /i https://dl.winehq.org/wine/wine-mono/9.4.0/wine-mono-9.4.0-x86.msi && \
    wineserver -k && \
    wineboot -u

#
# Put the novetus launcher, launch scripts, default map and addons inside the container
#

COPY --chown=novetus:novetus --chmod=777 Launcher /Launcher
COPY --chown=novetus:novetus --chmod=777 defaults /defaults
COPY --chown=novetus:novetus --chmod=777 default.rbxl /default.rbxl
COPY --chown=novetus:novetus --chmod=777 addons /Launcher/data/addons
RUN touch /Launcher/data/config/servers.txt /Launcher/data/config/ports.txt

ENTRYPOINT ["/defaults/start.sh"]
