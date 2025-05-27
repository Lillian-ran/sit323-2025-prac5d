# Base image (Node.js LTS + Alpine Linux)
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install production dependencies
RUN npm install --production

# Copy application code
COPY . .

# Expose application port
EXPOSE 3000

# Startup command
CMD ["node", "app.js"]