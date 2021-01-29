FROM node:15.6.0-alpine3.10
RUN  npm config set registry http://registry.npm.taobao.org
RUN mkdir /src
ADD . /src
RUN chmod -R 777 /usr/local/lib/node_modules/
RUN  cd /src && npm i &&  npm run build
EXPOSE 3000
WORKDIR /src
CMD ["npm", "start"]
