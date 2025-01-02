# Build Stage: Install dependencies and build the app
FROM node:20 AS build-stage

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install

COPY . .

# Production Stage
FROM node:20-slim AS production-stage

WORKDIR /app

COPY --from=build-stage /app /app

RUN npm install --only=production

EXPOSE 3000

CMD ["npm", "start"]
