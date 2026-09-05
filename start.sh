#!/bin/bash

set -e

echo "================================="
echo "Starting Ubuntu Desktop..."
echo "================================="

vncserver -localhost no \
    -SecurityTypes None \
    -geometry 1024x768 \
    --I-KNOW-THIS-IS-INSECURE || true

if [ ! -f /root/self.pem ]; then
    openssl req -new \
        -subj "/C=JP" \
        -x509 \
        -days 365 \
        -nodes \
        -out /root/self.pem \
        -keyout /root/self.pem
fi

websockify -D \
    --web=/usr/share/novnc/ \
    --cert=/root/self.pem \
    6080 localhost:5901

echo "================================="
echo "Starting 3x-ui / Sanaei..."
echo "================================="

cd /usr/local/x-ui

./x-ui &

echo "3x-ui started."

tail -f /dev/null
