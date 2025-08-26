FROM ubuntu:22.04

LABEL org.opencontainers.image.source=https://github.com/linjixing/claw

COPY init /usr/bin

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y ca-certificates curl wget net-tools unzip tzdata vim sudo cron screen supervisor openssh-server --no-install-recommends; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo '[ -f "/home/.bashrc" ] && . /home/.bashrc' >> /root/.bashrc; \
    echo 'shell /bin/bash' >> /etc/screenrc; \
    echo 'termcapinfo xterm* ti@:te@' >> /etc/screenrc; \
    echo 'Asia/Shanghai' > /etc/timezone; \
    echo 'set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom' >> /etc/vim/vimrc; \
    echo 'set termencoding=utf-8' >> /etc/vim/vimrc; \
    echo 'set encoding=utf-8' >> /etc/vim/vimrc; \
    mkdir /var/run/sshd; \
    wget -qO- https://github.com/trzsz/trzsz-go/releases/download/v1.1.8/trzsz_1.1.8_linux_x86_64.tar.gz | tar -xz -C /usr/local/bin --strip-components=1 trzsz_1.1.8_linux_x86_64/trz trzsz_1.1.8_linux_x86_64/tsz; \
    wget -qO- https://github.com/fatedier/frp/releases/download/v0.64.0/frp_0.64.0_linux_amd64.tar.gz | tar -xz -C /usr/local/bin --strip-components=1 frp_0.64.0_linux_amd64/frps frp_0.64.0_linux_amd64/frpc; \
    wget -qO- https://github.com/SagerNet/sing-box/releases/download/v1.11.15/sing-box-1.11.15-linux-amd64.tar.gz | tar -xz -C /usr/local/bin --strip-components=1 sing-box-1.11.15-linux-amd64/sing-box; \
    curl -Lo xray.zip https://github.com/XTLS/Xray-core/releases/download/v25.7.26/Xray-linux-64.zip && unzip xray.zip xray geoip.dat geosite.dat -d /usr/local/bin && rm xray.zip; \
    curl -Lo /usr/local/bin/cloudflared https://github.com/cloudflare/cloudflared/releases/download/2025.7.0/cloudflared-linux-amd64 && chmod +x /usr/local/bin/cloudflared; \
    curl -Lo /usr/local/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64 && chmod +x /usr/local/bin/ttyd; \
    chown root:root -R /usr/local/bin/*; \
    chmod +x /usr/bin/init

ENTRYPOINT ["init"]

CMD [ "/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf" ]
