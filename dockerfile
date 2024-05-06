# Stage 1: Pobranie repozytorium z wykorzystaniem protokołu SSH
FROM alpine AS ssh

RUN apk add --no-cache openssh-client

COPY id_rsa /root/.ssh/id_rsa

RUN chmod 600 /root/.ssh/id_rsa

RUN echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config

WORKDIR /app

RUN ssh-keyscan -t rsa github.com >> /root/.ssh/known_hosts

# Stage 2: Budowa aplikacji
FROM node:16-alpine AS build

WORKDIR /app

COPY --from=ssh /app .

COPY . .

ARG VERSION
RUN npm version ${VERSION}

# Stage 3: Uruchomienie aplikacji na serwerze NGINX
FROM nginx:stable-alpine AS frontend

RUN apk add --no-cache curl

WORKDIR /usr/share/nginx/html

COPY --from=build /app /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY start.sh /usr/local/bin/

EXPOSE 80

HEALTHCHECK --interval=10s --timeout=5s \
    CMD curl -f http://localhost:80 || exit 1

CMD ["start.sh"]
