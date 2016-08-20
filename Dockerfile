FROM ubuntu:16.04
MAINTAINER James Fourman

# Install packages
RUN apt-get -y update

# Install MariaDB, Apache, PHP and misc tools
RUN apt-get -y install \
    supervisor \
    git \
    tree \
    apache2

# Add config files and scripts
ADD ./vhost.conf /etc/apache2/sites-available/example.conf
RUN mkdir -p /var/www/html/example
ADD ./example /var/www/html/example
RUN a2ensite example

# Configure servicies
ADD ./start.sh /start.sh
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

RUN chmod 755 /start.sh

VOLUME ["/var/www/html", "/var/log/apache2"]

EXPOSE 80

CMD ["/usr/bin/supervisord"]
