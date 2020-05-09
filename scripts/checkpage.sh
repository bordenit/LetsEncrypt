#!/bin/bash
openssl s_client -connect https://$domain:444
content=$(wget -qO- "https://$domain")
if [[ $content==*"Hello World!"* ]]
then
echo "HTTPS page loaded successfully"
else
echo "HTTPS page is not loading"
exit 1
fi
