FROM node:20.8.1-alpine
WORKDIR /usr/app
COPY . /usr/app
RUN npm i
RUN npm run build
EXPOSE 3000
CMD npm start