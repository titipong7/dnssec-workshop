docker run --rm -d -h grp1-resolv1 --name=grp1-resolv1 --net=wsnet --ip=192.168.1.53 --dns=203.159.77.77 -e TZ=UTC -p 32053:53 -p 32053:53/udp thnicf/gprx-resolve
docker run --rm -d -h grp1-resolv2 --name=grp1-resolv2 --net=wsnet --ip=192.168.1.54 --dns=203.159.77.77 -e TZ=UTC -p 32054:53 -p 32054:53/udp thnicf/gprx-resolve
docker exec -it grp1-resolv1 /bin/bash
docker exec -it grp1-resolv2 /bin/bash