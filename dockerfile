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

# Skopiuj tylko package.json i package-lock.json, aby uruchomić npm install przed kopiowaniem całego katalogu.
COPY --from=ssh /app/package.json /app/package-lock.json ./

# Uruchom npm install, aby zainstalować zależności przed kopiowaniem reszty plików.
RUN npm install

# Skopiuj resztę plików do katalogu roboczego.
COPY --from=ssh /app .

# Kopiowanie plików źródłowych aplikacji.
COPY . .

# Ustawianie wersji aplikacji zgodnie z wartością ARG VERSION.
ARG VERSION
RUN npm version ${VERSION}

# Stage 3: Uruchomienie aplikacji na serwerze NGINX
FROM nginx:stable-alpine AS frontend

RUN apk add --no-cache curl

WORKDIR /usr/share/nginx/html

# Skopiuj pliki z etapu budowania do katalogu html serwera NGINX.
COPY --from=build /app /usr/share/nginx/html

# Kopiowanie konfiguracji NGINX.
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Kopiowanie skryptu startowego.
COPY start.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/start.sh
# Expose port 80.
EXPOSE 80

# Ustawienie zdrowia kontenera.
HEALTHCHECK --interval=10s --timeout=5s \
    CMD curl -f http://localhost:80 || exit 1


# Uruchomienie skryptu startowego.
CMD ["start.sh"]
