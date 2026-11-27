# renovate: datasource=github-releases depName=zevnda/steam-game-idler
ARG SGI_VERSION=6.5.2

# Download stage, so the .deb never lands in a layer of the final image
FROM scratch AS sgi
ARG SGI_VERSION
ADD https://github.com/zevnda/steam-game-idler/releases/download/${SGI_VERSION}/Steam.Game.Idler_${SGI_VERSION}_amd64.deb /sgi.deb

FROM jlesage/baseimage-gui:ubuntu-24.04-v4.15.1@sha256:7d8766b2ecbd03073aff5446186c5304fa86dfe42365af87fbe1224e97945241

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG SGI_VERSION

# The base image defaults to en_US.UTF-8, which it doesn't ship
ENV LANG=C.UTF-8

LABEL org.opencontainers.image.source="https://github.com/wielorzeczownik/docker-steam-game-idler" \
  org.opencontainers.image.url="https://github.com/wielorzeczownik/docker-steam-game-idler" \
  org.opencontainers.image.documentation="https://github.com/wielorzeczownik/docker-steam-game-idler#readme" \
  org.opencontainers.image.title="docker-steam-game-idler" \
  org.opencontainers.image.description="Steam Game Idler in a browser, for servers and NAS boxes without a desktop" \
  org.opencontainers.image.authors="wielorzeczownik" \
  org.opencontainers.image.vendor="wielorzeczownik"

# Runtime libraries of the Tauri app, plus a session bus and keyring for its stored credentials.
# The .deb is only unpacked, since its dependency names don't all match Ubuntu's.
RUN --mount=type=bind,from=sgi,source=/sgi.deb,target=/tmp/sgi.deb \
  add-pkg libsecret-1-0 libayatana-appindicator3-1 libwebkit2gtk-4.1-0 libgtk-3-0 dbus-x11 gnome-keyring ca-certificates zenity xclip \
  && dpkg -x /tmp/sgi.deb / \
  && mkdir -p /etc/gtk-3.0 \
  && printf '[Settings]\ngtk-enable-animations=0\n' >/etc/gtk-3.0/settings.ini \
  && install_app_icon.sh "https://raw.githubusercontent.com/zevnda/steam-game-idler/${SGI_VERSION}/src-tauri/icons/icon.png" \
  && set-cont-env APP_NAME "Steam Game Idler" \
  && set-cont-env APP_VERSION "${SGI_VERSION}"

COPY rootfs/ /
