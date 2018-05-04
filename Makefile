EDITOR=vim

include /etc/os-release

all: install-prerequisites regconfig build

install-prerequisites:
	echo ${ID}
ifeq ("$(wildcard /usr/bin/docker)","")
	@echo install docker-ce, still to be tested
	sudo apt-get update
	sudo apt-get install \
    	apt-transport-https \
    	ca-certificates \
    	curl \
    	software-properties-common

	curl -fsSL https://download.docker.com/linux/${ID}/gpg | sudo apt-key add -
	sudo add-apt-repository \
   		"deb https://download.docker.com/linux/ubuntu \
   		`lsb_release -cs` \
   		stable"
	sudo apt-get update
	sudo apt-get install -y docker-ce
endif
ifeq ("$(wildcard /usr/local/bin/docker-commpose)","")
	sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
	sudo chmod +x /usr/local/bin/docker-compose
endif

build:
	docker-compose up --build -d 

up: 
	docker-compose up -d

down:
	docker-compose down

restart: down up
