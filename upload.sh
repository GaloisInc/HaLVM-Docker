
#!/bin/sh

docker login
docker push halvm/base
docker push halvm/base-gmp
docker push extended/base
docker push extended/base-gmp
