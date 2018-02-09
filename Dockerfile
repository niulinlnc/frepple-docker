FROM debian:latest
RUN apt-get -y -q update
RUN apt-get -y -q full-upgrade

RUN apt-get -y install python3-pip libpython3.4
RUN apt-get -y install libxerces-c3.1 apache2 libapache2-mod-wsgi-py3 python3-psycopg2
RUN apt-get -y install vim wget mc nano
RUN pip3 install openpyxl setuptools

ADD resources/ /resources 
WORKDIR /resources
RUN dpkg -i frepple_*.deb
RUN apt-get -f -y -q install

RUN tar -zxvf frepple_4.3.orig.tar.gz
WORKDIR /resources/django-frepple_3.0
RUN pip3 install djangorestframework

WORKDIR /resources/frepple-4.3
RUN python3.5  setup.py install
EXPOSE 8000 5432

ADD start.sh /usr/bin/startfrepple
CMD ["startfrepple"]

