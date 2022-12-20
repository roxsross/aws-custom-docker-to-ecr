#!/bin/bash
#!/bin/bash
DOMAIN=$(curl icanhazip.com)
SSLIP="$DOMAIN.sslip.io"
sudo yum update -y
sudo yum install -y wget zip unzip git
sudo amazon-linux-extras install nginx1 -y 
sudo amazon-linux-extras install epel -y
sudo systemctl enable nginx
sudo systemctl start nginx
cat > devops <<EOF
server {
        listen 80;
        listen [::]:80;
        root /var/www/devops/html;
        index index.html index.htm index.nginx-debian.html;
        server_name $SSLIP www.$SSLIP;
        location / {
                try_files $uri $uri/ /index.html;
        }
}
EOF
sudo mv devops /etc/nginx/conf.d/devops.conf 
sudo mkdir -p /var/www/devops/html/
git clone https://github.com/roxsross/front-devops-github.git
sudo mv front-devops-github/* /var/www/devops/html
sudo systemctl restart nginx
sudo yum install -y certbot python2-certbot-nginx
sudo certbot --nginx --register-unsafely-without-email --agree-tos -d "${SSLIP}" --cert-name jenkins