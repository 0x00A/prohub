FROM dockerfile/nodejs

ENV prohub_baseURL http://localhost:8080
ENV prohub_org Dockerfile Org
ENV prohub_port 8080
ENV prohub_host 0.0.0.0
ENV prohub_githubClient client
ENV prohub_githubSecret secret

WORKDIR /opt/app
EXPOSE 8080
VOLUME ["/opt/app/cachedb", "/opt/app/db"]
CMD ["node", "app/index.js"]

COPY package.json /tmp/package.json
RUN cd /tmp && npm install --production && cp -R node_modules /opt/app/

ADD . /opt/app/
RUN npm install browserify stylus && npm run bundle-js && npm run bundle-css
