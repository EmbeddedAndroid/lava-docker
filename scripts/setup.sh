#!/bin/bash
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
lava-server manage workers lava-slave-01
lava-server manage workers lava-slave-02
lava-server manage workers lava-slave-03
lava-server manage workers lava-slave-04
# Add QEMU devices
lava-server manage device-types add qemu
lava-server manage devices add --device-type qemu --worker lava-slave-01 qemu-01
lava-server manage device-dictionary --hostname qemu-01 --import /etc/dispatcher-config/devices/qemu.jinja2
lava-server manage devices add --device-type qemu --worker lava-slave-01 qemu-02
lava-server manage device-dictionary --hostname qemu-02 --import /etc/dispatcher-config/devices/qemu.jinja2
lava-server manage devices add --device-type qemu --worker lava-slave-01 qemu-03
lava-server manage device-dictionary --hostname qemu-03 --import /etc/dispatcher-config/devices/qemu.jinja2
lava-server manage devices add --device-type qemu --worker lava-slave-01 qemu-04
lava-server manage device-dictionary --hostname qemu-04 --import /etc/dispatcher-config/devices/qemu.jinja2
# Add IoT Devices
lava-server manage device-types add nrf52-nitrogen
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-02 nrf52-nitrogen-01
lava-server manage device-dictionary --hostname nrf52-nitrogen-01 --import /etc/dispatcher-config/devices/nrf52-nitrogen-01.jinja2
lava-server manage device-types add stm32-carbon
lava-server manage devices add --device-type stm32-carbon --worker lava-slave-02 stm32-carbon-01
lava-server manage device-dictionary --hostname stm32-carbon-01.jinja2 --import /etc/dispatcher-config/devices/stm32-carbon-01.jinja2
lava-server manage device-types add frdm-k64f
lava-server manage devices add --device-type frdm-k64f --worker lava-slave-02 frdm-k64f-01
lava-server manage device-dictionary --hostname frdm-k64f-01 --import /etc/dispatcher-config/devices/frdm-k64f-01.jinja2
# Add U-Boot Devices
lava-server manage device-types add imx7d-sbc-iot-imx7
lava-server manage devices add --device-type imx7d-sbc-iot-imx7 --worker lava-slave-03 imx7d-sbc-iot-imx7-01
lava-server manage device-dictionary --hostname imx7d-sbc-iot-imx7-01 --import /etc/dispatcher-config/devices/imx7d-sbc-iot-imx7-01.jinja2
