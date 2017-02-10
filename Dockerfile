FROM amazonlinux
MAINTAINER Christian Vizarra <christian.vizarra@flightdigitalmedia.com>

RUN yum update -y

RUN yum  -y install -y httpd24 php70 mysql56-server git zip --skip-broken
RUN yum -y install php70-gd php70-imap php70-mbstring php70-mysqlnd php70-opcache php70-pdo php70-pecl-apcu php70-zip
RUN cd /var/www/html & mkdir public
RUN touch public/index.html
RUN echo "Hello World" >> public/index.html
RUN sed -i "s/html\"\>/html\/public\"\>/g"  /etc/httpd/conf/httpd.conf
RUN sed -i "s/DirectoryIndex index.html/DirectoryIndex index.php index.html/g" /etc/httpd/conf/httpd.conf
RUN sed -i "s/AllowOverride None/AllowOverride All/g" /etc/httpd/conf/httpd.conf
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.o
RUN service httpd restart
RUN touch /etc/sysconfig/network & echo "HOSTNAME=localhost" > /etc/sysconfig/network
RUN service mysqld start

RUN /usr/bin/curl -sS https://getcomposer.org/installer |/usr/bin/php
RUN /bin/mv composer.phar /usr/local/bin/composer
RUN /usr/local/bin/composer create-project laravel/laravel /var/www/html --prefer-dist
RUN chmod -R 777 /var/www/html/storage

EXPOSE 80
EXPOSE 443

CMD ["/bin/bash"]
