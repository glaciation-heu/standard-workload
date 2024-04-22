FROM ubuntu:latest

RUN apt-get update && apt-get install -y gcc make mpich wget tar

RUN mkdir /code
WORKDIR /code

RUN wget https://www.nas.nasa.gov/assets/npb/NPB3.4.2.tar.gz && \
    tar -xzvf NPB3.4.2.tar.gz && \
    rm -r NPB3.4.2.tar.gz

ENV BENCH_NAME=cg
ENV CLASS=C
ENV PROC_NUM=4

WORKDIR /code/NPB3.4.2/NPB3.4-MPI
RUN cp config/make.def.template config/make.def && \
    cp config/suite.def.template config/suite.def
RUN make $BENCH_NAME CLASS=$CLASS
CMD ./bin/$BENCH_NAME.$CLASS.x -np $PROC_NUM