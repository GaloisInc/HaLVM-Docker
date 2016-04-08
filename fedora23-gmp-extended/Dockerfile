FROM halvm/halvm:fedora23-gmp-base

RUN halvm-cabal update && \
    halvm-cabal install cryptonite --constraint "cryptonite < 0.9" && \
    halvm-cabal install hans && \
    halvm-cabal install tls -f-network -fhans
