docker run --rm -d -h grp1-ns1 --name=grp1-ns1 --net=wsnet --ip=192.168.1.63 --dns=203.159.77.77 -e TZ=UTC -p 32063:53 -p 32063:53/udp thnicf/gprx-ns
docker run --rm -d -h grp1-ns2 --name=grp1-ns2 --net=wsnet --ip=192.168.1.64 --dns=203.159.77.77 -e TZ=UTC -p 32064:53 -p 32064:53/udp thnicf/gprx-ns
docker exec -it grp1-ns1 /bin/bash
docker exec -it grp1-ns2 /bin/bash