FROM kernelci/lava-docker:2017.04

# Add device configuration
COPY devices/* /etc/dispatcher-config/devices/

COPY scripts/setup.sh .

RUN \
  /start.sh && \
  cd /root/lava-server && \
  curl https://github.com/EmbeddedAndroid/lava-server/commit/78fdfa61e55eea4b5c1998a2e597e7ae737ce188.patch | git am && \
  curl https://github.com/EmbeddedAndroid/lava-server/commit/ac6a5878110afa06728c2df9dc85cc2889a71c86.patch | git am && \
  sed -i 's,git clone https://github.com/Linaro/pkg,git clone https://github.com/EmbeddedAndroid/pkg,g' /root/lava-server/share/debian-dev-build.sh && \ 
  sed -i 's,dch -v ${VERSION}-1 -D unstable "Local developer build",dch -v ${VERSION}-1 -b -D unstable "Local developer build",g' /root/lava-server/share/debian-dev-build.sh && \
  /root/lava-server/share/debian-dev-build.sh -p lava-server && \
  /stop.sh

COPY configs/lava-slave-03.yaml /etc/lava-server/dispatcher.d/

EXPOSE 69 80 5555 5556

CMD /start.sh && /setup.sh && bash
