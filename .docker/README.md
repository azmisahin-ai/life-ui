# Docker Build Description

The `.docker` structure in this folder contains the following components:

- **production**: Test environment Docker components
  - `.env`: Environment variables for production environment
  - `command.sh`: Commands to be run in the production environment
  - `docker-compose.yaml`: Docker Compose file
- **test**: Test environment Docker components

  - `.env`: Environment variables for testing environment
  - `command.sh`: Commands to be run in the test environment
  - `docker-compose.yaml`: Docker Compose file

- **development**: Development environment Docker components
  - `.env`: Environment variables for the development environment
  - `command.sh`: Commands to be run in the development environment
  - `docker-compose.yaml`: Docker Compose file

# Docker Build Description

The `.docker` structure in this folder contains the following components:

- `Dockerfile.$DISTRIB_ID`: Docker file and Linux Distrib ID
- `Dockerfile.alpine`: Alpine based image
- `Dockerfile.debian`: Debian based image

* Build and run image:

Alpine Image:

```
docker build -t template-alpine -f .docker/Dockerfile.alpine .
docker run -it --rm template-alpine /bin/sh
```

Debian Image:

```
docker build -t template-debian -f .docker/Dockerfile.debian .
docker run -it --rm template-debian /bin/sh
```

Explains how to get started with your project's development, testing, and production environments.

1. Navigate to the `production` folder:
   ```bash
   cd .docker/production
   ```
2. Create the production environment variables file (.env):

   ```
   nano .env
   ```

   Edit the .env file with the required production environment variables.

3. Build and run the production environment:
   ```
   docker-compose up --build -d
   ```
