#!/bin/bash
. getport.sh
echo "PORT:" $PORT
code-server --port $PORT --host=0.0.0.0 --auth=none & cloudflared tunnel --url http://localhost:$PORT
