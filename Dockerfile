FROM ubuntu:22.04

LABEL org.opencontainers.image.source=https://github.com/linjixing/claw

COPY init /usr/bin

RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update; \
    apt-get install -y ca-certificates curl wget net-tools unzip tzdata vim screen sudo supervisor openssh-server --no-install-recommends; \
    apt-get clean; \
    rm -rf /var/lib/apt/lists/*; \
    ln -snf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    echo "shell /bin/bash" >> /etc/screenrc; \
    echo "termcapinfo xterm* ti@:te@" >> /etc/screenrc; \
    echo "Asia/Shanghai" > /etc/timezone; \
    echo "set fileencodings=utf-8,gbk,utf-16le,cp1252,iso-8859-15,ucs-bom" >> /etc/vim/vimrc; \
    echo "set termencoding=utf-8" >> /etc/vim/vimrc; \
    echo "set encoding=utf-8" >> /etc/vim/vimrc; \
    wget https://github.com/trzsz/trzsz-go/releases/download/v1.1.8/trzsz_1.1.8_linux_x86_64.tar.gz; \
    tar -zxf trzsz_1.1.8_linux_x86_64.tar.gz; \
    mv trzsz_1.1.8_linux_x86_64/* /usr/local/bin/; \
    rm -rf trzsz_1.1.8_linux_x86_64*; \
    curl -Lo /usr/bin/ttyd https://github.com/tsl0922/ttyd/releases/download/1.7.7/ttyd.x86_64; \
    chmod +x /usr/bin/ttyd;\
    chmod +x /usr/bin/init

ENTRYPOINT ["init"]

CMD [ "/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf" ]
