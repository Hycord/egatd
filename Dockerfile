FROM node:18

# Create app directory
WORKDIR /usr/app

# Install app dependencies
COPY package*.json ./
COPY prisma ./prisma
ENV NODE_ENV=production
RUN npm install

COPY . .

RUN npx prisma generate -- --schema=/usr/app/prisma/schema.prisma
RUN npm run build

WORKDIR /usr/app/dist

EXPOSE 3000 
CMD ["node", "index.js"]
















# FROM node:16.13-alpine as builder
# WORKDIR /app

# ENV DOCKER_BUILDKIT=1 
# # Not sure if you will need this
# # RUN apk add --update openssl

# COPY package*.json ./
# RUN npm ci --quiet

# COPY ./prisma prisma
# COPY ./src src
# RUN npm run build

# # Production image

# FROM node:16.13-alpine
# WORKDIR /app
# ENV NODE_ENV production

# COPY package*.json ./
# RUN npm ci --only=production --quiet

# COPY --chown=node:node --from=builder /app/prisma /app/prisma
# COPY --chown=node:node --from=builder /app/dist /app/dist
# RUN npx prisma generate -- --schema=/app/prisma/schema.prisma

# USER node

# EXPOSE 8080
# CMD ["node", "dist/index.js"]