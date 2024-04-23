FROM ubuntu:latest

RUN apt-get update && apt-get install -y gcc make mpich wget tar

RUN mkdir /code
WORKDIR /code

RUN wget https://www.nas.nasa.gov/assets/npb/NPB3.4.2.tar.gz && \
    tar -xzvf NPB3.4.2.tar.gz && \
    rm -r NPB3.4.2.tar.gz

# You can change BENCH_NAME and CLASS.
# BENCH_NAME:
#   Five kernels
#       IS - Integer Sort, random memory access
#       EP - Embarrassingly Parallel
#       CG - Conjugate Gradient, irregular memory access and communication
#       MG - Multi-Grid on a sequence of meshes, long- and short-distance communication, memory intensive
#       FT - discrete 3D fast Fourier Transform, all-to-all communication
#   Three pseudo applications
#       BT - Block Tri-diagonal solver
#       SP - Scalar Penta-diagonal solver
#       LU - Lower-Upper Gauss-Seidel solver
#   Benchmarks for unstructured computation, parallel I/O, and data movement
#       DT - Data Traffic
# CLASS:
#   S: small for quick test purposes
#   W: workstation size (a 90's workstation; now likely too small)
#   A, B, C: standard test problems; ~4X size increase going from one class to the next
#   D, E, F: large test problems; ~16X size increase from each of the previous classes
ENV BENCH_NAME=ft
ENV CLASS=C

WORKDIR /code/NPB3.4.2/NPB3.4-MPI
RUN cp config/make.def.template config/make.def && \
    cp config/suite.def.template config/suite.def
RUN make $BENCH_NAME CLASS=$CLASS
CMD ./bin/$BENCH_NAME.$CLASS.x