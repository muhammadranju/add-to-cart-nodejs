FROM node:18 as builder

WORKDIR /build

COPY package*.json .
RUN npm install

COPY src/ src/

RUN npm run build

FROM node:18 as runner

WORKDIR /app

COPY --from=builder build/package*.json .
COPY --from=builder build/node_modules node_modules

CMD [ "npm", "start" ]