From node:9.2-slim

RUN apt-get update && apt-get -y install ttf-wqy-microhei && rm -rf /var/lib/apt/lists/*
ADD url-to-pdf /root/app

RUN apt-get update && apt-get install -y wget --no-install-recommends \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-unstable \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge --auto-remove -y curl \
    && rm -rf /src/*.deb

RUN cd /root/app && npm install

ENV PUPPETEER_CHROMIUM_PATH google-chrome-unstable
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

WORKDIR /root/app
CMD [ "npm", "start"]
