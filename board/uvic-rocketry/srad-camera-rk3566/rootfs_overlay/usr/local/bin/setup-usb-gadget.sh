#!/bin/sh

# Setup USB gadget serial for console
modprobe libcomposite

GADGET_DIR="/sys/kernel/config/usb_gadget/g1"

mkdir -p "$GADGET_DIR"
cd "$GADGET_DIR"

echo 0x1d6b > idVendor  # Linux Foundation
echo 0x0104 > idProduct # Multifunction Composite Gadget
echo 0x0100 > bcdDevice # v1.0.0
echo 0x0200 > bcdUSB    # USB 2.0

mkdir -p strings/0x409
echo "fedcba9876543210" > strings/0x409/serialnumber
echo "UVIC Rocketry" > strings/0x409/manufacturer
echo "SRAD Camera" > strings/0x409/product

# Create serial function
mkdir -p functions/acm.usb0

# Create configuration
mkdir -p configs/c.1/strings/0x409
echo "Serial" > configs/c.1/strings/0x409/configuration
echo 250 > configs/c.1/MaxPower

# Link function to configuration
ln -s functions/acm.usb0 configs/c.1/

# Find and enable the UDC
UDC=$(ls /sys/class/udc | head -n1)
echo "$UDC" > UDC
