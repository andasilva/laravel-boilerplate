FROM nginx:alpine

ADD conf.d/nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=boiler-app:latest /var/www/public /var/www/public
