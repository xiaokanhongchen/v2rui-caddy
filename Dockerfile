FROM debian:latest
#更新源
RUN apt-get -y update && apt-get -y upgrade
#安装ssh
RUN apt install openssh-server -y
RUN apt install curl -y
RUN apt install wget -y
RUN apt install unzip -y

#同步系统时间
RUN cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
#修改root
RUN sed -i "s/#PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/#PasswordAuthentication yes/PasswordAuthentication yes/g" /etc/ssh/sshd_config
RUN echo root:123456789 |chpasswd root

#install caddy rui2v
RUN curl -L -o /caddy.tar.gz --insecure https://github.com/caddyserver/caddy/releases/download/v1.0.3/caddy_v1.0.3_linux_amd64.tar.gz \
 && tar -zxvf /caddy.tar.gz caddy \
 && mv caddy /usr/bin \
 && rm -rf /caddy* \
 && chmod +x /usr/bin/caddy \
 && mkdir /wwwroot
ADD index.html /wwwroot/index.html
ADD Caddyfile /etc/Caddyfile
ADD ./ ./
RUN mv ./rui2v /usr/bin && chmod +x /usr/bin/rui2v \
 && mv ./v2ctl /usr/bin && chmod +x /usr/bin/v2ctl


ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 9090
ENTRYPOINT ["/entrypoint.sh"]
