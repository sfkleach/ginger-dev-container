# ginger-dev-container
A small project that integrates with Dockerhub to produce fast-start ginger 
development containers. 

To use this container, create a volume to persist the project files. A good 
name for this volume is "spicery", to mirror the github organisation.

	docker volume create spicery

Start the container as follows

	docker run -it --name gdev --mount src=spicery,dst=/spicery sfkleach/ginger-dev-container

The first time the container starts up, it will clone the ginger repository
onto the volume and build the Ginger system. It will then install Ginger
inside the container and exit to the bash shell.