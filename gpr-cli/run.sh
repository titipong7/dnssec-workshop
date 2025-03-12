docker run --rm -d -h grp1-cli --name=grp1-cli --net=wsnet --ip=192.168.1.2 --dns=203.159.77.77 ubuntu
docker exec -it grp1-cli /bin/bash

