FROM nginx:stable
# hadolint ignore=DL4000
LABEL maintainer="Sudarshana Sharma <sudarshana.sharma7@gmail.com>"
MAINTAINER = "sudarshana.sharma7@gmail.com"
RUN apt-get update && apt-get install -y nginx
#RUN gosu cp default /etc/nginx/sites-enabled/
RUN rm -rf  /var/www/html/index.html
COPY index.html /var/www/html/

EXPOSE 8000
# EXPOSE 800000
CMD ["nginx", "-g" , "daemon off;"]