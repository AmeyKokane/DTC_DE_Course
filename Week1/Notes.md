# Docker

## Docker Intro

1. What is Docker?
- Open source Containerizaton platform. 
- Containerization is the packaging of software code with just the operating system (OS) libraries and dependencies required to run the code to create a single lightweight executable—called a container—that runs consistently on any infrastructure.
- Docker delivers packaged software containers that are in isolation from each other but will be able to communicate with each other if proper channel is created.


2. Why do we need Docker
- Portability: Containers run without any modification across OS, Desktops and Cloud Environments
- Reproducibility: Allows recreation of Docker Images that are snapshots in technical as well as literal sense.
- Local experiments: ephemeral nature of docker containers allows for experimental buildup and takedown of containers without a lot of resources.

## How to a build a Docker Container

- First, Install Docker
- To confirm docker is installed properly, run below code in command line utitlity 
```Docker 
   Docker run -it hello-world
```
   * This code downloads hello-world docker image
   * -it command tells docker to run image in Interactive Mode

- Using a text editor, create a file name 'Dockerfile' (Docker File is a simple text file containing instructions for how to build a docker container image) and   type below code

**Dockerfile**
```Dockerfile
FROM python:3.9

RUN pip install pandas

ENTRYPOINT ["bash"]

```
- Above code uses dockers base python image, installs pandas library and uses bash commandline as entry point for the container image
- FROM tells docker which base image to use
- RUN tells docker what code to run when the base image is being initialized
- ENTRYPOINT tells docker to start the specified program(or list of programs) when image starts


### Useful Docker Commands

Some useful commands that have helped me resolve some issues:

```docker ps``` - Lists running containers

```docker ps -a``` - Lists all containers, including stopped ones

```docker stop <container id>``` - Stops a running container

```docker rm <container id>``` - Removes a stopped container

```docker rm $(docker ps --filter status=exited -q)``` - Removes all stopped containers

```docker network ls``` - Lists all running networks

```docker network rm <network id>``` - Removes a network


# Terraform Overview

## Concepts

### Introduction

1 What is Terraform?

Open source tool used for provisioning infrastructure resources like VMs, Containers, Storage or Networking
Resources are provisioned using declarative configuration files
Uses IaC approach which leads to DevOps best practices
2 IaC

Infrastructure-as-Code
Allows to build, change and manage infrastructure in safe and repeatable way by defining resource configurations that you can version, reuse and share
In laymans terms it is like GitHub but for infrastructure
Allows to manage infrastructure using configuration files as well as GUI
