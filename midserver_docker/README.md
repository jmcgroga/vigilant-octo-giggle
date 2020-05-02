# Quick Guide

## Download a MID Server package

## Extract to servicenow directory

## Build the image

```
docker build --tag midserver_docker:0.1 .
```

## Create the MID Server container

```
./create_mid_container.sh <MID NUMBER>
```

This script will prompt for instance, username, and password each time.  Set the environment variables MID_INSTANCE, MID_USERNAME, and MID_PASSWORD to set the values from the environment instead of prompting for each.

## Start the MID Server container

```
docker start mid<NUMBER>
```