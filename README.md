# Sparky is a demo Rails application

## Frontend

Frontend files are located in the `/public` directory. Nginx exposes this content directly without requests to backend.

## Backend

Backend upstream is bound to the `/api` namespace. It has two routes:
- `POST /api/messages` — receives message params and stores a record in PostgreSQL.
- `GET  /api/check` — returns `Hello world!` string if the application works correctly.

## Puma

Puma is configured to listen to UNIX-socket.

## Nginx config

HTTP/2 and SSL are enabled.

```
upstream sparky {
  server unix:/path/to/sparky/shared/sockets/puma.sock;
}

server {
  ssl_certificate /etc/letsencrypt/live/sparky.rediron.ru/fullchain.pem; # managed by Certbot
  ssl_certificate_key /etc/letsencrypt/live/sparky.rediron.ru/privkey.pem; # managed by Certbot

  include snippets/ssl-params.conf;

  listen 443 ssl http2;
  listen [::]:443 ssl http2;

  server_name sparky.rediron.ru; # change to match your URL
  root /path/to/sparky/current/public; # I assume your app is located at that location

  error_log /var/log/nginx/sparky.rediron.ru-error.log;
  access_log /var/log/nginx/sparky.rediron.ru-access.log;

  location /api/ {
    proxy_set_header X-Real-IP  $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_redirect off;

    proxy_pass http://sparky/;
  }
}
```
