FROM python:3.4
ENV PYTHONUNBUFFERED 1

# Build BLAS and LAPACK, required for scipy
RUN apt-get update && \
    apt-get install -y libblas-dev liblapack-dev gfortran

# create directory in which code will be present inside container
RUN mkdir /ams-nbfc
WORKDIR /ams-nbfc

# install requirements.txt
COPY requirements.txt .
RUN pip install --cache-dir /tmp/pip-cache -r requirements.txt

# copy source code
COPY . .

CMD ["echo", "installed requirements and code copied, run alternate cmds"]
