FROM node:16.16.0-alpine AS INSTALLER

WORKDIR /usr/src/app
COPY package.json yarn.lock ./

RUN yarn global add @nestjs/cli

COPY . .
RUN yarn --prod

RUN yarn build

FROM node:16.16.0-alpine

WORKDIR /usr/src/app

COPY --from=INSTALLER /usr/src/app .

ENV LAUNCH_ENV docker-compose

CMD ["node", "dist/main.js"]
EXPOSE ${CONTAINER_PORT}