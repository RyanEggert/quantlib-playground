## Installation

### Boost
Using Boost 1.66.0
```bash
./bootstrap.sh --prefix=/usr/local/
sudo ./b2
sudo ./b2 install
```

### QuantLib
Using QuantLib 1.12
```bash
export CC=clang-6.0
export CXX=clang++-6.0
./configure --enable-openmp --enable-parallel-unit-test-runner --enable-error-lines --enable-examples --enable-thread-safe-singleton-init
make -j16
sudo make install
```

### CMake
Using CMake 3.11
```bash
./bootstrap --prefix=~/opt/cmake/build
make -j${NPROC}
make install
# use ~/opt/cmake/build/bin/cmake
```

