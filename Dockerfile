FROM node:20-alpine  # Use a Node.js 20 Alpine image

# Install build dependencies
RUN apk --no-cache add curl python3 make gcc g++ openssl bash

WORKDIR /app  # Set working directory to /app

# Copy package.json and package-lock.json to /app (root)
COPY package.json package-lock.json ./

# Install dependencies using npm ci (clean install)
RUN npm ci --legacy-peer-deps #Use this to install, and to ignore peer dependency warnings.

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Expose the port your app runs on (likely 5560, but check your code)
EXPOSE 5560

# Set the default shell to bash (for easier debugging, not strictly needed)
SHELL ["/bin/bash", "-c"]

# Command to start the application
CMD ["npm", "start"]
