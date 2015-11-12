FROM zalando/python:3.4.0-2

COPY requirements.txt /
RUN pip3 install -r /requirements.txt

# copy project code
ADD nakadi /nakadi
# remove python cache files
RUN find ./nakadi | grep -E "(__pycache__|\.pyc|\.pyo$)" | xargs rm -rf

WORKDIR /

ENV METRICS_FOLDER /tmp_metrics
RUN mkdir ${METRICS_FOLDER}
RUN chmod 777 ${METRICS_FOLDER}

COPY nginx.conf /
RUN apt-get update && \
    apt-get install -y ca-certificates nginx && \
    rm -rf /var/lib/apt/lists/*

COPY nakadi.sh /
CMD ./nakadi.sh

EXPOSE 8080
