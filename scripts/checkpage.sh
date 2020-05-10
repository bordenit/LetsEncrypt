#!/bin/bash
content=$(wget -qO- "https://$domain")
if [[ $content==*$GITHUB_SHA* ]]
then
echo "HTTPS page loaded successfully"
else
echo "HTTPS page is not loading"
exit 1
fi
