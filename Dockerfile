FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update -y && apt install --no-install-recommends -y \
    xfce4 xfce4-goodies \
    tigervnc-standalone-server \
    novnc websockify \
    sudo xterm \
    vim net-tools curl wget git tzdata \
    dbus-x11 x11-utils x11-xserver-utils x11-apps \
    ca-certificates openssl

RUN apt update -y && \
    apt install -y firefox xubuntu-icon-theme

RUN touch /root/.Xauthority

# Install 3x-ui / Sanaei
RUN wget -q https://github.com/MHSanaei/3x-ui/releases/latest/download/x-ui-linux-amd64.tar.gz \
    -O /tmp/x-ui.tar.gz && \
    mkdir -p /usr/local/x-ui && \
    tar -xzf /tmp/x-ui.tar.gz -C /usr/local/x-ui --strip-components=1 && \
    chmod +x /usr/local/x-ui/x-ui && \
    chmod +x /usr/local/x-ui/bin/xray-linux-amd64

COPY start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 6080
EXPOSE 2053

CMD ["/start.sh"]
