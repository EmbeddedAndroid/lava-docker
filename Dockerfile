FROM kernelci/lava-docker:2017.05

# Add device configuration
COPY devices/* /etc/dispatcher-config/devices/

# Add device-type configuration
COPY device-types/* /etc/dispatcher-config/device-types/

COPY scripts/setup.sh .

RUN \
  /start.sh && \
  cd /root/lava-server && \
  curl https://github.com/EmbeddedAndroid/lava-server/commit/c411b86db01c2cd4664b130077cfb0e1d7ba28b3.patch | git am && \
  curl https://github.com/EmbeddedAndroid/lava-server/commit/dbdd2b5ae5f46a34336108344c430cc78d31949c.patch | git am && \
  curl https://github.com/EmbeddedAndroid/lava-server/commit/8fbd32eeaaa149a669cfbb4be63792557d7ded8c.patch | git am && \
  sed -i 's,git clone https://github.com/Linaro/pkg,git clone https://github.com/EmbeddedAndroid/pkg,g' /root/lava-server/share/debian-dev-build.sh && \ 
  /root/lava-server/share/debian-dev-build.sh -p lava-server && \
  /stop.sh

COPY configs/lava-slave-03.yaml /etc/lava-server/dispatcher.d/

EXPOSE 69/udp 80 5555 5556

CMD /start.sh && /setup.sh && bash
