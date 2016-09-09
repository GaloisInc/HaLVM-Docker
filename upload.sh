
#!/bin/sh

docker login
docker push halvm/base
docker push halvm/base-gmp
docker push halvm/extended
docker push halvm/extended-gmp
