#!/bin/bash
$dockerContainerPath = "$dockerHubUserName/$dockerHubContainerName"
echo $dockerHubPassword | docker login -u $dockerHubUsername --password-stdin
CONTAINERID=$(docker ps -a -q)
if [ ! -z "$CONTAINERID" ]
then
docker stop $CONTAINERID > /dev/null
docker rm $CONTAINERID 2>/dev/null || true
else
echo "No Containers to Remove"
fi
docker pull $dockerHubContainerPath
docker run -v ~/x509stores/:/root/.dotnet/corefx/cryptography/x509stores/ --name mcmaster -d -p 80:80 -p 443:443 -e "ASPNETCORE_ENVIRONMENT=Production" -e ASPNETCORE_URLS="http://+;https://+" -e ASPNETCORE_HTTPS_PORT=443 $dockerHubContainerPath
