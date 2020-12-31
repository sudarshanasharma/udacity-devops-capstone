FROM nginx:latest

##hadolint ignore=DL3003
#-ignore DL3003 --ignore DL300
#LABEL maintainer="Sudarshana Sharma <sudarshana.sharma7@gmail.com>"
#MAINTAINER = "sudarshana.sharma7@gmail.com"
###RUN apt-get update && apt-get install -y ngi
#WORKDIR /usr/share/nginx/html/
RUN rm -rf  /usr/share/nginx/html/*
COPY index.html /usr/share/nginx/html/
#RUN cd /usr/share/nginx/html/ && cat index.html
EXPOSE 80
# EXPOSE 800000
CMD ["nginx", "-g" , "daemon off;"]
