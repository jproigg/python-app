# imagen base
FROM alpine:3.5

# Install python and pip
RUN apk add --update py2-pip

# install requirements
COPY requirements.txt /usr/src/app/
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

# copy archivos 
COPY app.py /usr/src/app/
COPY templates/index.html /usr/src/app/templates/

# puerto
EXPOSE 5000

# correr el app
CMD ["python", "/usr/src/app/app.py"]