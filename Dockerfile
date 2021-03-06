FROM tutum/apache-php:latest
MAINTAINER Borja Burgos <borja@tutum.co>, Feng Honglin <hfeng@tutum.co>

ENV WORDPRESS_VER 4.3.1
WORKDIR /
RUN apt-get update && \
    apt-get -yq install mysql-client curl && \
    rm -rf /app && \
    curl -0L http://wordpress.org/latest.tar.gz | tar zxv && \
    mv /wordpress /app && \
    rm -rf /var/lib/apt/lists/*

RUN sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
RUN sed -i "s/upload_max_filesize.*/upload_max_filesize = 100M/g" /etc/php5/apache2/php.ini
RUN sed -i "s/post_max_size.*/post_max_size = 100M/g" /etc/php5/apache2/php.ini
RUN a2enmod rewrite
ADD wp-config.php /app/wp-config.php
ADD run.sh /run.sh
RUN chmod +x /*.sh

# Expose environment variables
ENV DB_HOST **LinkMe**
ENV DB_PORT **LinkMe**
ENV DB_NAME wordpress
ENV DB_USER admin
ENV DB_PASS **ChangeMe**

EXPOSE 80
VOLUME ["/app/wp-content"]
CMD ["/run.sh"]
