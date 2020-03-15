FROM tensorflow/tensorflow:latest-gpu

RUN export DEBIAN_FRONTEND=noninteractive
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update -y && apt upgrade -y


WORKDIR /usr/src/app/

COPY . .
RUN apt install -y -q $(cat ./dependencies.conf) --fix-missing

RUN git clone https://github.com/jernst98/ChromHMM.git

EXPOSE 5000
