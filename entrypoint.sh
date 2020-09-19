#!/bin/sh
#ssh
service ssh restart

# V2Ray new configuration
cat <<-EOF > /etc/config.json
{
	"inbounds": [{
		"port": "9090",
		"protocol": "vmess",
		"settings": {
			"clients": [ {"id": "580814c2-a784-44d0-9380-56aa03a7de75",	"alterId": 64} ]
		},
		"streamSettings": {
			"network": "ws",
			"security": "auto",
			"wsSettings": {
				"path": "/v2rui"
			}
		}
	},{
	   "port": 443,
       "protocol": "vless",
       "settings": {
            "clients": [
                    {
                        "id": "580814c2-a784-44d0-9380-56aa03a7de75",
                        "level": 0,
                        "email": "love@v2rui"
                    }
                ],
                "decryption": "none"
          },
          "streamSettings": {
                "network": "tcp",
                "security": "auto"
          }
	}],
	"outbound": {
		"protocol": "freedom",
		"settings": {}
	},
	"dns": {
		"servers": [ "176.103.130.130", "8.8.8.8", "1.1.1.1", "114.114.114.114"]
	}
}
EOF
# Run V2Ray
nohup /usr/bin/rui2v -config /etc/config.json >v2.txt 2>&1 &
VERSION=$(/usr/bin/rui2v --version |grep V |awk '{print $2}')
REBOOTDATE=$(date)
sed -i "s/VERSION/$VERSION/g" /wwwroot/index.html
sed -i "s/REBOOTDATE/$REBOOTDATE/g" /wwwroot/index.html

caddy -conf="/etc/Caddyfile"
