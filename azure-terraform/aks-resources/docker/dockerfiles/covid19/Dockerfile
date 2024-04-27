FROM httpd
LABEL maintainer="DevOps Easy Learning"
ARG port=80
USER root
RUN apt -y update && \
    apt -y install wget && \
    apt -y install unzip
WORKDIR /usr/local/apache2/htdocs/

RUN wget https://linux-devops-course.s3.amazonaws.com/covid19.zip && \
    unzip covid19.zip && \
    cp -r covid19/* . && \
    rm -rf  covid19.zip && \
    rm -rf  covid19
    
ENTRYPOINT ["httpd-foreground"]
EXPOSE ${port}
