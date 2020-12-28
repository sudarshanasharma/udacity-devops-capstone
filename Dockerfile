FROM nginx:latest

# hadolint ignore=DL4000
#LABEL maintainer="Sudarshana Sharma <sudarshana.sharma7@gmail.com>"
#MAINTAINER = "sudarshana.sharma7@gmail.com"
###RUN apt-get update && apt-get install -y nginx
###WORKDIR /usr/share/nginx/html/
RUN cd /usr/share/nginx/html/ && ls
##RUN cd /var/www/html/ && cat index.html
#ADD . /var/www
#RUN chown -R www-data:www-data /var/www
###RUN ls /var/www/html/ >>log.txt
#RUN gosu cp default /etc/nginx/sites-enabled/
RUN rm -rf  /usr/share/nginx/html/*
COPY index.html /usr/share/nginx/html/
RUN cd /usr/share/nginx/html/ && ls
RUN cd /usr/share/nginx/html/ && cat index.html
EXPOSE 8000
# EXPOSE 800000
CMD ["nginx", "-g" , "daemon off;"]