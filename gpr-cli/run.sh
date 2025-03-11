docker run --rm -d -h grp1-cli --name=grp1-cli --net=wsnet --ip=10.0.0.2 --dns=203.159.70.209 --dns=203.159.77.77 ubuntu
docker exec -it grp1-cli /bin/bash

