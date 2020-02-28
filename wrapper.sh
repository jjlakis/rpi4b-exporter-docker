#!/bin/bash
while [ true ]; do sleep 1; raspberrypi_exporter; done &
node_exporter --collector.textfile.directory=/var/lib/node_exporter/textfile_collector
