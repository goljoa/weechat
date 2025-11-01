FROM debian:stable-slim

ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    weechat torsocks openssl ca-certificates tzdata curl \
 && rm -rf /var/lib/apt/lists/*

# user non-root
RUN groupadd -g 1000 weechat || true \
 && useradd -m -u 1000 -g 1000 -s /bin/bash weechat

# torsocks config
COPY torsocks.conf /etc/torsocks.conf

# entrypoint
COPY start-weechat.sh /usr/local/bin/start-weechat.sh
RUN chmod +x /usr/local/bin/start-weechat.sh

USER weechat
WORKDIR /home/weechat
ENV HOME=/home/weechat

CMD ["/usr/local/bin/start-weechat.sh"]

