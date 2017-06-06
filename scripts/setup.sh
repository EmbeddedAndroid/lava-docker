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
lava-server manage workers add lava-slave-01
lava-server manage workers add lava-slave-02
lava-server manage workers add lava-slave-03
lava-server manage workers add lava-slave-04
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
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-02 nrf52-nitrogen-01 --tags fota zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-01 --import /etc/dispatcher-config/devices/nrf52-nitrogen-01.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-02 nrf52-nitrogen-02 --tags fota zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-02 --import /etc/dispatcher-config/devices/nrf52-nitrogen-02.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-04 nrf52-nitrogen-03 --tags zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-03 --import /etc/dispatcher-config/devices/nrf52-nitrogen-03.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-04 nrf52-nitrogen-04 --tags zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-04 --import /etc/dispatcher-config/devices/nrf52-nitrogen-04.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-04 nrf52-nitrogen-05 --tags zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-05 --import /etc/dispatcher-config/devices/nrf52-nitrogen-05.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-04 nrf52-nitrogen-06 --tags zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-06 --import /etc/dispatcher-config/devices/nrf52-nitrogen-06.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-04 nrf52-nitrogen-07 --tags zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-07 --import /etc/dispatcher-config/devices/nrf52-nitrogen-07.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-03 nrf52-nitrogen-08 --tags e2e zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-08 --import /etc/dispatcher-config/devices/nrf52-nitrogen-08.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-03 nrf52-nitrogen-09 --tags e2e zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-09 --import /etc/dispatcher-config/devices/nrf52-nitrogen-09.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-03 nrf52-nitrogen-10 --tags e2e zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-10 --import /etc/dispatcher-config/devices/nrf52-nitrogen-10.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-03 nrf52-nitrogen-11 --tags e2e zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-11 --import /etc/dispatcher-config/devices/nrf52-nitrogen-11.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-03 nrf52-nitrogen-12 --tags e2e zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-12 --import /etc/dispatcher-config/devices/nrf52-nitrogen-12.jinja2
lava-server manage devices add --device-type nrf52-nitrogen --worker lava-slave-03 nrf52-nitrogen-13 --tags e2e zephyr
lava-server manage device-dictionary --hostname nrf52-nitrogen-13 --import /etc/dispatcher-config/devices/nrf52-nitrogen-13.jinja2
lava-server manage device-types add stm32-carbon
lava-server manage devices add --device-type stm32-carbon --worker lava-slave-02 stm32-carbon-01
lava-server manage device-dictionary --hostname stm32-carbon-01.jinja2 --import /etc/dispatcher-config/devices/stm32-carbon-01.jinja2
lava-server manage device-types add frdm-k64f
lava-server manage devices add --device-type frdm-k64f --worker lava-slave-02 frdm-k64f-01 --tags fota zephyr
lava-server manage device-dictionary --hostname frdm-k64f-01 --import /etc/dispatcher-config/devices/frdm-k64f-01.jinja2
lava-server manage devices add --device-type frdm-k64f --worker lava-slave-04 frdm-k64f-02 --tags zephyr
lava-server manage device-dictionary --hostname frdm-k64f-02 --import /etc/dispatcher-config/devices/frdm-k64f-02.jinja2
# Add U-Boot Devices
lava-server manage device-types add imx7d-sbc-iot-imx7
lava-server manage devices add --device-type imx7d-sbc-iot-imx7 --worker lava-slave-01 imx7d-sbc-iot-imx7-01
lava-server manage device-dictionary --hostname imx7d-sbc-iot-imx7-01 --import /etc/dispatcher-config/devices/imx7d-sbc-iot-imx7-01.jinja2
lava-server manage device-types add imx6q-cm-fx6
lava-server manage devices add --device-type imx6q-cm-fx6 --worker lava-slave-03 imx6q-cm-fx6-01
lava-server manage device-dictionary --hostname imx6q-cm-fx6-01 --import /etc/dispatcher-config/devices/imx6q-cm-fx6-01.jinja2
# Add Fastboot Devices
lava-server manage device-types add hi6220-hikey
lava-server manage devices add --device-type hi6220-hikey --worker lava-slave-01 hi6220-hikey-01
lava-server manage device-dictionary --hostname hi6220-hikey-01 --import /etc/dispatcher-config/devices/hi6220-hikey-01.jinja2
