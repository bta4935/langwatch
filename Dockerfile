FROM node:20-alpine

# Install build dependencies
RUN apk --no-cache add curl python3 make gcc g++ openssl bash

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm ci --legacy-peer-deps

COPY . .

RUN npm run build

EXPOSE 5560

SHELL ["/bin/bash", "-c"]

CMD ["npm", "start"]
