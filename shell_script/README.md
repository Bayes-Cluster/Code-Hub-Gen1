# Terminal-Based Code-Server


## Explanation

1. `getport.sh` can help finding a unused port
2. `webcode.sh` can run the Code-Server on the specific port from `getport.sh` and establish a tunnel via the [CloudFlare](https://github.com/cloudflare/cloudflared) service

## Preliminary

1. follow Cloudflare's instruction to install `cloudflared` || [cloudfalred doc](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/installation)
2. (optional) `sudo mv getport.sh /usr/bin/getport` and `sudo mv webcode.sh /usr/bin/webcode`
3. (optional) `sudo chmod 755 /usr/bin/getport` and `sudo chmod 755 /usr/bin/webcode`
4. `ping 1.1.1.1` and make sure your server can connect to Cloudflare's DNS server

If you follow these three steps, all the user can use `webcode` to use the `Code-Server` on the web tunnel :-)
