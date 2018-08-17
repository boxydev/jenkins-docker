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

## How to backup / restore

There is other methods to manage data with Docker than volume. But for us, it better to avoid fighting with permissions on mount. When data are in volume, you can retrieve easily but wait, before that, be sure that container who use volume is STOPPED to avoid inconsitent data's state.

```
docker-compose stop

# Backup (remove $ on fish)
mkdir -p ~/backups/jenkins
docker run -v jenkins_home:/volume --rm loomchild/volume-backup backup - > ~/backups/jenkins/$(date '+%Y-%m-%d-%Hh%Mm%S').tar.bz2

# Restore (Please be sure that file exists)
cat ~/backups/jenkins/2018-08-17-23h58m36.tar.bz2 | docker run -i -v jenkins_home:/volume --rm loomchild/volume-backup restore -
```
