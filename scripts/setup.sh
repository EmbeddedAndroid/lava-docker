#!/bin/bash
# Set LAVA Server IP
if [[ -n "$LAVA_SERVER_IP" ]]; then
	sed -i "s/.*LAVA_SERVER_IP =.*/LAVA_SERVER_IP = $LAVA_SERVER_IP/g" /etc/lava-dispatcher/lava-dispatcher.conf
fi
# Create the kernel-ci user
echo "from django.contrib.auth.models import User; User.objects.create_superuser('kernel-ci', 'admin@localhost.com', 'kernel-ci')" | lava-server manage shell
# Set the kernel-ci user's API token
if [[ -n "$KCI_API_TOKEN" ]]; then
	lava-server manage tokens add --user kernel-ci --secret $KCI_API_TOKEN
else
	lava-server manage tokens add --user kernel-ci
fi
# Set the admin token
if [[ -n "$ADMIN_API_TOKEN" ]]; then
	lava-server manage tokens add --user admin --secret $ADMIN_API_TOKEN
else
	lava-server manage tokens add --user admin
fi
# Add workers
lava-server manage pipeline-worker --hostname lava-slave-01
lava-server manage pipeline-worker --hostname lava-slave-02
# Add QEMU devices
lava-server manage device-types add qemu
lava-server manage add-device --device-type qemu --worker lava-slave-01 qemu-01
lava-server manage device-dictionary --hostname qemu-01 --import /etc/dispatcher-config/devices/qemu.jinja2
lava-server manage add-device --device-type qemu --worker lava-slave-01 qemu-02
lava-server manage device-dictionary --hostname qemu-02 --import /etc/dispatcher-config/devices/qemu.jinja2
lava-server manage add-device --device-type qemu --worker lava-slave-01 qemu-03
lava-server manage device-dictionary --hostname qemu-03 --import /etc/dispatcher-config/devices/qemu.jinja2
lava-server manage add-device --device-type qemu --worker lava-slave-01 qemu-04
lava-server manage device-dictionary --hostname qemu-04 --import /etc/dispatcher-config/devices/qemu.jinja2
# Add IoT Devices
lava-server manage device-types add nrf52-nitrogen
lava-server manage add-device --device-type nrf52-nitrogen --worker lava-slave-01 nrf52-nitrogen-01
lava-server manage device-dictionary --hostname nrf52-nitrogen-01 --import /etc/dispatcher-config/devices/nrf52-nitrogen-01.jinja2
lava-server manage device-types add stm32-carbon
lava-server manage add-device --device-type stm32-carbon --worker lava-slave-01 stm32-carbon-01
lava-server manage device-dictionary --hostname stm32-carbon-01.jinja2 --import /etc/dispatcher-config/devices/stm32-carbon-01.jinja2
lava-server manage device-types add frdm-k64f
lava-server manage add-device --device-type frdm-k64f --worker lava-slave-01 frdm-k64f-01
lava-server manage device-dictionary --hostname frdm-k64f-01 --import /etc/dispatcher-config/devices/frdm-k64f-01.jinja2
