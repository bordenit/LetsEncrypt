#!/bin/sh
echo $dockerHubPassword | docker login -u $dockerHubUsername --password-stdin
CONTAINERID=$(docker ps -a -q) /dev/null
docker stop $CONTAINERID > /dev/null
docker rm $CONTAINERID 2>/dev/null || true
echo "No Containers to Remove"
docker pull $dockerHubUsername/$dockerHubContainerName
docker run -v ~/x509stores/:/root/.dotnet/corefx/cryptography/x509stores/ --name $dockerHubContainerName -d -p 80:80 -p 443:443 -e "ASPNETCORE_ENVIRONMENT=Production" -e ASPNETCORE_URLS="http://+;https://+" -e ASPNETCORE_HTTPS_PORT=443 $dockerHubUsername/$dockerHubContainerName
echo $dockerHubPassword | docker login -u $dockerHubUsername --password-stdin
