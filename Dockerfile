From node:9.2-slim

RUN apt-get update && apt-get install -y wget ttf-wqy-microhei --no-install-recommends \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y google-chrome-unstable \
      --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get purge --auto-remove -y curl \
    && rm -rf /src/*.deb

RUN groupadd -r pptruser && useradd -r -g pptruser -G audio,video pptruser \
    && mkdir -p /home/pptruser/Downloads \
    && chown -R pptruser:pptruser /home/pptruser/

ADD url-to-pdf /home/pptruser/app

WORKDIR /home/pptruser/app

RUN yarn

USER pptruser

ENV PUPPETEER_CHROMIUM_PATH google-chrome-unstable
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD true

CMD [ "npm", "start"]
