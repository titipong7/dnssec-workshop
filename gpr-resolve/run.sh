docker run --rm -d -h grp1-resolv1 --name=grp1-resolv1 --net=wsnet --ip=10.0.0.67 --dns=203.159.70.209 --dns=203.159.77.77 -e TZ=UTC -p 32053:53 -p 32053:53/udp ubuntu/bind9:9.18-22.04_beta
docker exec -it grp1-resolv1 /bin/bash
