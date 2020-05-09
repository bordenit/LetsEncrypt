#!/bin/bash
content=$(wget -qO- "https://$domain")
if [[ $content==*"Hello World!" ]]
then
echo "HTTPS page loaded successfully"
else
echo "HTTPS page is not loading"
exit 1
echo $content
