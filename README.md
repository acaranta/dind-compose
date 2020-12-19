# DinD (Docker in Docker) with docker-compose

This Docker image provides Docker inside itself, which allows you to run any Docker container.

This image is designed to run everything with Docker, so it doesn't pre-install any execution environment for any specific programming language. Instead, simply run the images you need from the public Docker Hub or your private Docker registry.

This Docker image is based on [killercentury/docker-jenkins-dind](https://github.com/killercentury/docker-jenkins-dind). 

Run it with mounted directory from host:

```
docker run -d acaranta/dind-compose
```

You can also use it to access/control your host docker daemon (be CAREFUL tho) :
```
docker run -d -v /var/run/docker.sock:/var/run/docker.sock  acaranta/dind-compose
```

