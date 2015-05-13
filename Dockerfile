FROM tutum/nginx:latest

RUN apt-get update
RUN apt-get install -y \
  supervisor \
  curl \
  wget \
  php5-fpm \
  php5-mysql \
  php5-mcrypt \
  php5-gd \
  php5-memcached \
  php5-curl \
  php5-xdebug

# Create required directories
RUN mkdir -p /var/log/supervisor
RUN mkdir -p /etc/nginx
RUN mkdir -p /var/run/php5-fpm

# Not yet working, log to docker output
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log
RUN ln -sf /dev/stdout /var/log/php5-fpm.log

# Add configuration files
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose volumes
VOLUME ["/var/www", "/etc/nginx/sites-enabled"]

EXPOSE 80 9000 9001

CMD ["/usr/bin/supervisord"]