FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt install --no-install-recommends -y \
    xfce4 xfce4-goodies \
    tigervnc-standalone-server \
    novnc websockify \
    sudo xterm \
    vim net-tools curl wget git tzdata \
    dbus-x11 x11-utils x11-xserver-utils x11-apps \
    software-properties-common \
    ca-certificates openssl

RUN add-apt-repository ppa:mozillateam/ppa -y

RUN echo 'Package: *' >> /etc/apt/preferences.d/mozilla-firefox && \
    echo 'Pin: release o=LP-PPA-mozillateam' >> /etc/apt/preferences.d/mozilla-firefox && \
    echo 'Pin-Priority: 1001' >> /etc/apt/preferences.d/mozilla-firefox

RUN apt update -y && \
    apt install -y firefox xubuntu-icon-theme

RUN touch /root/.Xauthority

# Download 3x-ui
RUN ARCH=amd64 && \
    wget -q https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-${ARCH}.tar.gz -O /tmp/x-ui.tar.gz && \
    cd /tmp && \
    tar -xzf x-ui.tar.gz && \
    chmod +x x-ui/x-ui x-ui/bin/xray-linux-* && \
    mv x-ui /usr/local/x-ui

COPY start.sh /start.sh
RUN chmod +x /start.sh

EXPOSE 6080
EXPOSE 2053

CMD ["/start.sh"]
