# Use Node.js 18 Alpine image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy backend package files
COPY backend/package*.json ./backend/

# Install backend dependencies
RUN cd backend && npm install --only=production

# Copy backend source code
COPY backend/ ./backend/

# Expose port
EXPOSE 5000

# Set working directory to backend
WORKDIR /app/backend

# Start the application
CMD ["node", "server.js"]