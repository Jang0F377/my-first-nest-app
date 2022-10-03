# Build stage
FROM node:16.14.2 AS build

WORKDIR /app

COPY package*.json ./
RUN npm set-script prepare '' && npm ci --production

COPY scripts/build_prereq.sh ./
RUN chmod +x build_prereq.sh
RUN ./build_prereq.sh

COPY src/ ./src
COPY tsconfig*.json ./

RUN npm run build:nest

RUN npm prune --production


# Production deploy stage
FROM node:16.14.2-alpine as production
EXPOSE 3000

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY --from=build /app/dist ./dist
COPY --from=build /app/node_modules ./node_modules
COPY src/docker/scripts/entrypoint.sh /usr/local/bin/entrypoint.sh
COPY package.json .

RUN apk add bash

#Copy .env and seed-data files if exist. Used for local debugging.
COPY lock_docker seed-data.jso[n] .en[v] ./ 

CMD ["/usr/local/bin/entrypoint.sh"]
