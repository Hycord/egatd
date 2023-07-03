FROM node:18

# Create app directory
WORKDIR /usr/app

# Install app dependencies
COPY package*.json ./
COPY prisma ./prisma
ENV NODE_ENV=production
RUN npm install

COPY . .

RUN npm run init
RUN npm run build

WORKDIR /usr/app/dist

EXPOSE 3000 
CMD ["node", "index.js"]
