FROM ubuntu:20.04


RUN mkdir ./app
RUN chmod 777 ./app
WORKDIR /app

RUN apt -qq update

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Kolkata


RUN apt -qq install -y git aria2 wget curl busybox unzip unrar tar python3 ffmpeg python3-pip
RUN wget -qO- https://api.github.com/repos/mawaya/rclone/releases/latest \
  | grep browser_download_url | grep linux-amd64 | cut -d '"' -f 4 \
  | wget --no-verbose -i-
RUN unzip -j fclone*.zip -d /usr/bin && chmod 0755 /usr/bin/fclone

RUN mkdir /app/gautam
RUN wget -O /app/gautam/gclone.gz https://git.io/JJMSG
RUN gzip -d /app/gautam/gclone.gz
RUN chmod 0775 /app/gautam/gclone

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt
COPY . .
CMD ["bash","start.sh"]
