From node:9.2-slim

RUN apt-get update && apt-get -y install ttf-wqy-microhei && rm -rf /var/lib/apt/lists/*
ADD url-to-pdf /root/app

RUN cd /root/app && npm install

WORKDIR /root/app
CMD [ "npm", "start"]
