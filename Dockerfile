FROM node:8-alpine
WORKDIR /usr/app/src
ADD . ./
RUN npm install
CMD npm start
EXPOSE 3000
