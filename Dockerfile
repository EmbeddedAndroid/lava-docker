FROM kernelci/lava-docker:2017.04

# Add device configuration
COPY devices/* /etc/dispatcher-config/devices/

COPY scripts/setup.sh .

RUN \
  /start.sh && \
  cd /root/lava-server && \
  curl https://github.com/EmbeddedAndroid/lava-server/commit/78fdfa61e55eea4b5c1998a2e597e7ae737ce188.patch | git am && \
  /root/lava-server/share/debian-dev-build.sh -p lava-server && \
  /stop.sh


EXPOSE 22 80 5555 5556
CMD /start.sh && /setup.sh && bash
