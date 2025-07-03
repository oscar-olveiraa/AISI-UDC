FROM python:3.13.1-alpine
ENV FLASK_APP=counter.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=5000
ENV FLASK_DEBUG=True
RUN pip install flask redis MarkupSafe
RUN apk --no-cache add curl
WORKDIR /src
### COPY src /src
EXPOSE 5000/tcp
### HEALTHCHECK CMD curl --fail http://127.0.0.1:5000 || exit 1
ENTRYPOINT ["flask", "run"]
