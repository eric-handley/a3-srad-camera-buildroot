#!/bin/sh

UART_DEV="/dev/ttyS0"

while true; do
    echo "PING: $(date +%s)" > "$UART_DEV"
    sleep 5
done