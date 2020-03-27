FROM tensorflow/tensorflow:latest-gpu

RUN export DEBIAN_FRONTEND=noninteractive
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -y

WORKDIR /usr/src/app/

COPY . .
RUN rm Dockerfile
RUN apt install -y -q $(cat dependencies.conf) --fix-missing

RUN git clone https://github.com/jernst98/ChromHMM.git
RUN chmod +x /usr/src/app/scripts/PREPROCESS.sh

EXPOSE 5000
