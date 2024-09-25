FROM registry.access.redhat.com/ubi8-init:latest
MAINTAINER ohubohu@tuk.tam
LABEL Version="Version 0.0001 Improved"

# You have to create servername directive
RUN yum install -y httpd && yum clean all && systemctl enable httpd &&\ 
    echo "Let's see what will be" > /var/www/html/index.html &&\
    echo "ServerName  my.local.host" >> /etc/httpd/conf/httpd.conf &&\
    sed -i 's/80/8080/g' /etc/httpd/conf/httpd.conf &&\
    mkdir /etc/systemd/system/httpd.service.d/; echo -e '[Service]\nRestart=    always' > /etc/systemd/system/httpd.service.d/httpd.conf

COPY run_httpd.sh /usr/local/bin/
#RUN chmod -x /usr/local/bin/run_httpd.sh


ARG PORT=8080
EXPOSE	$PORT

# ENTRYPOINT [ "/usr/sbin/httpd" ]
CMD ["run_httpd.sh"]
