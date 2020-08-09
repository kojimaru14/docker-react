# Multi-setp build process

### Build Phase ###
# tagged as "builder" phase
FROM node:14.7-alpine
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
# static files are created in /app/build
RUN npm run build

### Run Phase ###
# By putting 2nd FROM, it means 2nd phase is started.
FROM nginx
EXPOSE 80
# We want copy /app/build (created in "builder" phase) to the path for nginx
COPY --from=0 /app/build /usr/share/nginx/html