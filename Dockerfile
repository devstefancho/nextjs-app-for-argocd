# Use the official Node.js 18 image
FROM node:18-alpine

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Next.js app
RUN npm run build

# Expose the port that Next.js will run on
EXPOSE 3000

# Start the application
CMD ["npm", "start"]