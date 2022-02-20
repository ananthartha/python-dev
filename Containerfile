FROM arm64v8/python:slim

RUN apt update && apt install curl sed openssh-server openssh-client openssh-sftp-server -y && \
  sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config && \
  sed -i 's/#PermitRootLogin prohibit-password/#PermitRootLogin no/g' /etc/ssh/sshd_config

EXPOSE 22

WORKDIR /
COPY ./entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]