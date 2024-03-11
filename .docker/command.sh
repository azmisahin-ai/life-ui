#!/bin/sh

# Application launch commands.
echo PRODUCTION

# environment
echo APP_ENV=$APP_ENV
echo APP_NAME=$APP_NAME

# build
echo DISTRIB_ID=$DISTRIB_ID
echo WORKSPACE_FOLDER=$WORKSPACE_FOLDER

# Physical
echo PROJECT_FOLDER=$PROJECT_FOLDER
echo DATA_FOLDER=$DATA_FOLDER

# DEPLOY
echo RESOURCE_CPUS=$RESOURCE_CPUS
echo RESOURCE_GPUS=$RESOURCE_GPUS
echo RESOURCE_MEMORY=$RESOURCE_MEMORY
echo SCALE=$SCALE

# SERVER
echo HOST_IP=$HOST_IP
echo HOST_IP=$HOST_IP
echo HTTP_PORT=$HTTP_PORT
echo HTTPS_PORT=$HTTPS_PORT
echo TCP_PORT=$TCP_PORT
echo SOCKET_PORT=$SOCKET_PORT
echo HTTP_PORT_RANGE=$HTTP_PORT_RANGE
echo HTTPS_PORT_RANGE=$HTTPS_PORT_RANGE
echo TCP_PORT_RANGE=$TCP_PORT_RANGE
echo SOCKET_PORT_RANGE=$SOCKET_PORT_RANGE

# SWICHS
echo SWICH_TRACKING_TRACE=$SWICH_TRACKING_TRACE
echo SWICH_TRACKING_DEBUG=$SWICH_TRACKING_DEBUG
echo SWICH_TRACKING_INFO=$SWICH_TRACKING_INFO
echo SWICH_TRACKING_WARN=$SWICH_TRACKING_WARN
echo SWICH_TRACKING_ERROR=$SWICH_TRACKING_ERROR
echo SWICH_TRACKING_VERBOSE=$SWICH_TRACKING_VERBOSE
echo SWICH_TRACKING_REPORT=$SWICH_TRACKING_REPORT

# Application

# Create Nginx configuration file
cat <<EOL > nginx.conf
events {
    worker_connections 1024;
}

http {
    server {
        listen $HTTP_PORT;
        server_name localhost;

        location / {
            root /usr/share/nginx/html;
            index index.html;
        }
    }
}
EOL

# Start Nginx with the created configuration file
nginx -c $(pwd)/nginx.conf -g 'daemon off;'


# /bin/sh
