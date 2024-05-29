all: host vol
	sudo chmod 777 /var/run/docker.sock
	@docker compose -f ./srcs/docker-compose.yml up -d --build

host:
	sudo sed -i 's|localhost|jocorrea.42.fr|g' /etc/hosts

down:
	@docker compose -f ./srcs/docker-compose.yml down

re:
	@docker compose -f srcs/docker-compose.yml up -d --build

vol:
	mkdir -p $(HOME)/data/mysql
	mkdir -p $(HOME)/data/wordpress
	sudo chown -R $(USER) $(HOME)/data
	sudo chmod -R 777 $(HOME)/data

status :
	@docker ps -a

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\
	sudo rm -rf $(HOME)/data/

.PHONY: all re down clean
