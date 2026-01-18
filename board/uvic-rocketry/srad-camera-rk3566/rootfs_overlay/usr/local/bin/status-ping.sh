#!/bin/sh

UART_DEV="/dev/ttyS0"
BAUD_RATE="115200"

# Configure UART baud rate and settings
stty -F "$UART_DEV" "$BAUD_RATE" cs8 -cstopb -parenb raw

while true; do
    echo "PING: $(date +%s)" > "$UART_DEV"
    sleep 5
done