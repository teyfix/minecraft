# Use an official Debian runtime as a parent image
FROM debian:latest

# Set environment variables
ENV RCON_HOST=localhost
ENV RCON_PORT=25575
ENV RCON_PASSWORD=password

# Install mcrcon
RUN apt-get update && \
  apt-get install -y wget && \
  wget https://github.com/Tiiffi/mcrcon/releases/download/v0.7.1/mcrcon-0.7.1-linux-x86-64.tar.gz && \
  tar -zxvf mcrcon-0.7.1-linux-x86-64.tar.gz && \
  mv mcrcon /usr/local/bin/mcrcon && \
  chmod +x /usr/local/bin/mcrcon && \
  apt-get remove -y wget && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* mcrcon-0.7.1-linux-x86-64.tar.gz

# Add the oplist.txt file
COPY oplist.txt /oplist.txt

# Add a script to update the oplist
COPY update_oplist.sh /update_oplist.sh
RUN chmod +x /update_oplist.sh

# Set the entry point to the update script
ENTRYPOINT ["/update_oplist.sh"]
