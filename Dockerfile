From microbox/node-url-to-pdf-api

RUN apt-get update && apt-get -y install ttf-wqy-microhei && rm -rf /var/lib/apt/lists/*

RUN rm -rf /root/node_modules && rm /root/package.json
ADD url-to-pdf/node_modules /root/node_modules
ADD url-to-pdf/package.json /root/package.json

