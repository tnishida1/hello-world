#!/bin/sh                                                                                             
export AUTH=$(cat /root/.docker/config.json | sed -n 's/.*auth.*"\(.*\)".*/\1/p'| tail -1 | base64 -d)
                                                                                                  
curl -u $AUTH -X POST "https://harbor.toolchain.lead.sandbox.liatr.io/api/chartrepo/jlab/charts" \
  -H "Content-Type: multipart/form-data" \                           
  -F "chart=@hello-world-0.1.0.tgz;type=application/x-compressed-tar"

