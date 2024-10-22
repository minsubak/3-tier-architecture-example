# 3-Tier Architecture Example

This repository exists for an example for a 3-tier architecture training.

### Concept
![3-tier-architecture drawio|1400](https://github.com/user-attachments/assets/df312367-05be-4ee7-b657-608e9b63408e)


### Test Environment
```
- Ubuntu 22.04.04 LTS (jammy)
- Docker 27.0.3 build 7d4bcd8
- Docker Compose v2.28.1
- Containerd 1.7.18
```

### Command
```bash
cd {your work directory}
git clone https://github.com/minsubak/3-tier-architecture-example.git
docker build -t u22-systemd .
docker compose up -d

# If you connect to a container
docker exec -it {container name or id} bash
```

### Dockerfile.template
Need to typing your domain, port and db info.
```Dockerfile
FROM ubuntu:22.04

# arg
ARG DEBIAN_FRONTEND=noninteractive

# env
ENV TZ=Asia/Seoul \
    SERVER_DOMAIN=[your_domain] \
    WEB_ADDR1=apache1 \ 
    WEB_ADDR2=apache2 \
    WEB_N_LB_PORT=[your_port|recommand_80] \
    INLB_ADDR=nginx2 \
    WAS_ADDR1=tomcat1 \
    WAS_ADDR2=tomcat2 \
    DB_ADDR=mysql1 \
    DB_USERNAME=[db_username] \
    DB_PASSWORD=[db_password] 

# install systemctl and etc package
RUN apt update \
    && apt install -qq -y init systemd \
    && apt install -qq -y build-essential \
    && apt install -qq -y tzdata locales gettext\
    && apt install -qq -y openssh-server \
    && apt install -qq -y vim curl net-tools\
    && apt-get clean autoclean \
    && apt-get autoremove -y \
    && rm -rf /var/lib/{apt, dpkg, cache, log}

# ect work
RUN systemctl enable ssh
RUN echo 'your_name:your_password' | chpasswd
RUN locale-gen [your_language_pack]
ENV LC_ALL=[your_language_pack]
WORKDIR /root

EXPOSE 00000

# run systemctl
CMD ["/sbin/init"]
```

### Else
When testing in a localhost or arbitrarily configured domains, modifications to the hosts file are required.
```
C:\Windows\System32\drivers\etc\hosts
```

These files are examples for training; under normal circumstances, additional security settings may be required, and I am not responsible for any problems caused by arbitrary modifications to those files.
