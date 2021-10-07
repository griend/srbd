# Debian 11 - Bullseye (Stable)
FROM debian:bullseye

RUN apt-get update && apt-get -y full-upgrade && apt-get install -y hugo nginx && apt-get clean

COPY . /site

RUN hugo -v --source=/site --destination=/var/www/html/

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
