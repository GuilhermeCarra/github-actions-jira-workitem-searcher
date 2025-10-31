FROM ubuntu:22.04

# Install Atlassian CLI via binary download
RUN apt-get update && apt-get install -y curl \
    && curl -LO "https://acli.atlassian.com/linux/latest/acli_linux_amd64/acli" \
    && chmod +x acli \
    && install -o root -g root -m 0755 acli /usr/local/bin/acli

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]