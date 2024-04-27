FROM httpd
LABEL maintainer="DevOps Easy Learning"
ARG port=80
USER root
RUN apt -y update && \
    apt -y install wget && \
    apt -y install unzip
WORKDIR /usr/local/apache2/htdocs/

RUN wget https://linux-devops-course.s3.amazonaws.com/phone.zip && \
    unzip phone.zip && \
    cp -r phone/* . && \
    rm -rf  phone.zip && \
    rm -rf  phone
    
ENTRYPOINT ["httpd-foreground"]
EXPOSE ${port}
