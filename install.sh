#!/bin/bash

AppName="debian";
UserName="kot624";
Version="3";

docker volume create $UserName
docker build -t $UserName/$AppName:v$Version .
docker run -d --name $UserName -p 24:22 -v $UserName:/var/lib/docker/volumes/$UserName/_data $UserName/$AppName:v$Version
