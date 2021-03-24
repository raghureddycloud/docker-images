# Using Apline version for both Node and Nginx 
FROM node:10.16.0-alpine

# Create app directory
WORKDIR /app

# Change ownership of the directory 
RUN chown -R node:node /app

# Install app dependencies
COPY package.json /app

# Install all app dependencies and python module(modify as per requirment)
RUN apk update && apk add --no-cache python make

# Change user to Node for Security consideration
USER node

# Install all app dependencies and python module
RUN npm install

# Copy the content into Container
COPY --chown=node:node  . /app

# Expose container on Port 9001
EXPOSE 9001

# Start Node command 
CMD ["node", "app.js"]