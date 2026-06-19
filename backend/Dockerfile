FROM node:18-alpine

WORKDIR /app

# 1. Copy only dependency files first (better caching)
COPY package*.json ./

# 2. Use more stable install method for CI/Docker builds
RUN npm config set registry https://registry.npmjs.org \
 && npm config set fetch-retries 5 \
 && npm config set fetch-retry-mintimeout 20000 \
 && npm config set fetch-retry-maxtimeout 120000 \
 && npm install --no-audit --no-fund --prefer-offline

# 3. Copy the rest of the app
COPY . .

# 4. Expose backend port
EXPOSE 3001

# 5. Start app
CMD ["npm", "start"]
