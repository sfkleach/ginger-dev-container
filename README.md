# ginger-dev-container
A small project that integrates with Dockerhub to produce fast-start ginger 
development containers. 

To use this container, create a folder to persist the project files. A good 
name for this folder is "Spicery", to mirror the github organisation e.g.

	mkdir /projects/Spicery

Start the container as follows

	docker run -it --name gdev -v type=bind,src=/projects/Spicery,dst=/spicery sfkleach/ginger-dev-container

The first time the container starts up, it will clone the ginger repository
onto the shared folder and build the Ginger system. It will then install Ginger
inside the container and exit to the bash shell.

## What Does This Provide?

  * You are logged in as user gdev with password gdev in a bash shell.
  * Ginger's repo is cloned onto /spicery/ginger, which is a shared folder.
  * Environment variables SPICERY_DEV_HOME and GINGER_DEV_HOME are set.
  * All package dependencies have been installed.
  * The working directory is on the development branch.
  * The working directory has been built (configured and compiled).
  * Ginger has been installed into /usr/local, which is private to the container.
