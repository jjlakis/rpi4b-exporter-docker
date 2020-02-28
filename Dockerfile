FROM ubuntu
RUN apt-get update && apt-get install -y curl unzip python3-pip git

# Install node exporter
RUN curl -SL https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-armv7.tar.gz > node_exporter.tar.gz && \
tar -xvf node_exporter.tar.gz -C /usr/local/bin/ --strip-components=1

# Install raspberry pi exporter
RUN curl -sL "https://github.com/fahlke/raspberrypi_exporter/archive/master.zip" > "/tmp/raspberrypi_exporter.zip"
RUN unzip -qq -o "/tmp/raspberrypi_exporter.zip" -d "/tmp"
RUN mv "/tmp/raspberrypi_exporter-master/raspberrypi_exporter" "/usr/local/sbin/"
RUN chmod +x "/usr/local/sbin/raspberrypi_exporter"

# Build userland
RUN apt-get install -y cmake gcc-aarch64-linux-gnu g++-aarch64-linux-gnu
RUN git clone https://github.com/raspberrypi/userland.git
WORKDIR /userland
RUN ./buildme --aarch64
RUN cp /userland/build/bin/* /usr/local/bin/

# Preare textfile collector
RUN mkdir -p /var/lib/node_exporter/textfile_collector
ADD wrapper.sh /

EXPOSE 9100

ENTRYPOINT ["/wrapper.sh"]

CMD ["/wrapper.sh"]



