# Using Apline version for both Node and Nginx 
FROM node:10.16.0-alpine as builder

# Create app directory
WORKDIR /app

# Install app dependencies
COPY package*.json  /app/

# Install all app dependencies
RUN npm install

# Copy project files into the docker image
COPY . /app

# Build as Prod Build (can be customized as per project requirment)
RUN npm run build -- --prod

# STEP 2 build a small nginx image with static website
FROM nginx:alpine

## Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

## From 'builder' copy website to default nginx public folder
COPY --from=builder /app/dist /usr/share/nginx/html

## Copy Nginx config file
COPY default.conf /etc/nginx/conf.d/

# Expose container on Port 80
EXPOSE 80

# Start Nginx command 
CMD ["nginx", "-g", "daemon off;"]