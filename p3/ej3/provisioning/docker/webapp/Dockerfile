FROM ubuntu:jammy
RUN apt-get update \
	&& apt-get install -y pkg-config libmysqlclient-dev python3-pip python3-dev \
	&& pip3 install flask flask-sqlalchemy mysqlclient \
	&& apt-get --purge autoremove \
	&& apt-get autoclean \
	&& apt-get clean all
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000
ENV FLASK_DEBUG=True
WORKDIR /var/www
COPY src /var/www
EXPOSE 5000/tcp
ENTRYPOINT ["flask", "run"]
