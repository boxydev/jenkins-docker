# Jenkins in Docker

We need to run Jenkins "portable" in a docker container. It work everywhere where Docker is present, on my Macbook Pro or a cloud instance. Great, I can run CI when I need it ! But we need too to run container in our pipelines's projects. Oh inception ! We can run Docker in Docker too. We use socat to manage Docker on Mac OS because we cannot share socket easily like Linux.

## Usage

Install docker and create dot env file from dot env dist file.

```
cp .env.dist .env
docker volume create --name=jenkins_home
docker-compose up
```

You can access Jenkins at http://localhost:8080

Be sure to manage volume "jenkins_home" to preserve your data.
