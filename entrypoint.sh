#!/usr/bin/env sh

useradd -s /bin/bash -d /home/$USER -G sudo $USER
echo "$USER ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$USER
usermod -aG root $USER

if [ ! -d "/home/$USER" ]; then
    mkdir -p /home/$USER/bin
    mkdir -p /home/$USER/conf/supervisor
    mkdir -p /home/$USER/.ssh
    chmod 700 /home/$USER/.ssh
    touch /home/$USER/.ssh/authorized_keys
    chmod 600 /home/$USER/.ssh/authorized_keys
    chown $USER:$USER -R /home/$USER
fi

cat > /etc/supervisord.conf << EOF
; supervisor config file

[unix_http_server]
file=/var/run/supervisor.sock   ; (the path to the socket file)
chmod=0700                       ; sockef file mode (default 0700)

[supervisord]
nodaemon=true
logfile=/tmp/supervisord.log ; (main log file;default /supervisord.log)
pidfile=/var/run/supervisord.pid ; (supervisord pidfile;default supervisord.pid)
childlogdir=/tmp            ; ('AUTO' child log dir, default )

; the below section must remain in the config file for RPC
; (supervisorctl/web interface) to work, additional interfaces may be
; added by defining them in separate rpcinterface: sections
[rpcinterface:supervisor]
supervisor.rpcinterface_factory = supervisor.rpcinterface:make_main_rpcinterface

[supervisorctl]
serverurl=unix:///var/run/supervisor.sock ; use a unix:// URL  for a unix socket

; The [include] section can just contain the "files" setting.  This
; setting can list multiple files (separated by whitespace or
; newlines).  It can also contain wildcards.  The filenames are
; interpreted as relative to this file.  Included files *cannot*
; include files themselves.

[program:sshd]
command=/usr/sbin/sshd -D
logfile=/tmp/sshd.log
stdout_logfile=/tmp/sshd.log
stderr_logfile=/tmp/sshd.log
autostart=true
autorestart=true

[program:ttyd]
environment=HOME="/home/$USER",USER="$USER",LOGNAME="$USER"
command=/usr/bin/ttyd -t enableTrzsz=true -c $USER:password -W bash
directory=/home/$USER
logfile=/tmp/ttyd.log
stdout_logfile=/tmp/ttyd.log
stderr_logfile=/tmp/ttyd.log
autostart=true
autorestart=true
user=$USER

[include]
files = /home/$USER/conf/supervisor/*.conf
EOF

exec "$@"
