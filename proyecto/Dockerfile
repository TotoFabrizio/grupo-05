# Stage 1: install dependencies
FROM node:18-alpine AS dependencies
WORKDIR /usr/src/app

# Copy package files and install only production dependencies
COPY package.json package-lock.json ./
RUN npm i

# Stage 2: runtime image
FROM node:18-alpine AS runtime
WORKDIR /usr/src/app

COPY --from=dependencies /usr/src/app/node_modules ./node_modules
COPY . ./

ENV NODE_ENV=development
ENV PORT=3001

EXPOSE 3001

CMD ["npm", "run", "start"]
