FROM httpd
LABEL maintainer="DevOps Easy Learning"
ARG port=80
USER root
RUN apt -y update && \
    apt -y install wget && \
    apt -y install unzip
WORKDIR /usr/local/apache2/htdocs/

RUN wget https://linux-devops-course.s3.amazonaws.com/articles.zip && \
    unzip articles.zip && \
    cp -r articles/* . && \
    rm -rf  articles.zip && \
    rm -rf  articles

RUN wget https://linux-devops-course.s3.amazonaws.com/covid19.zip && \
    unzip covid19.zip && \
    rm -rf  covid19.zip

RUN wget https://linux-devops-course.s3.amazonaws.com/creative.zip && \
    unzip creative.zip && \
    rm -rf  creative.zip

RUN wget https://linux-devops-course.s3.amazonaws.com/halloween.zip && \
    unzip halloween.zip && \
    rm -rf  halloween.zip

RUN wget https://linux-devops-course.s3.amazonaws.com/phone.zip && \
    unzip phone.zip  && \
    rm -rf  phone.zip 

RUN wget https://linux-devops-course.s3.amazonaws.com/static.zip && \
    unzip static.zip  && \
    rm -rf  static.zip 

RUN wget https://linux-devops-course.s3.amazonaws.com/website.zip && \
    unzip website.zip  && \
    rm -rf  website.zip 

ENTRYPOINT ["httpd-foreground"]
EXPOSE ${port}
