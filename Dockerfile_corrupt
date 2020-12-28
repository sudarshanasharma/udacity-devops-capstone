FROM nginx:stable
# hadolint ignore=DL4000
LABEL maintainer="Sudarshana Sharma <sudarshana.sharma7@gmail.com>"
MAINTAINER = "sudarshana.sharma7@gmail.com"

COPY index.html /var/www/html/

EXPOSE 80
# EXPOSE 800000
CMD ["nginx", "-g" , "daemon off;"]
