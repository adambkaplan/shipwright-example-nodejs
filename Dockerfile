FROM registry.access.redhat.com/ubi8/ubi:latest
RUN curl -sL https://rpm.nodesource.com/setup_14.x | bash -
ENV INSTALL_PKGS="gcc-c++ make nodejs"
RUN yum install -y $INSTALL_PKGS

WORKDIR /app/example-nodejs
COPY . .
RUN npm install

CMD ["node", "index.js"]
