#!/bin/bash
# Script de provisión para el servidor DNS - Juanma

echo "Actualizando sistema..."
apt-get update -y
apt-get upgrade -y

echo "Instalando BIND9..."
apt-get install -y bind9 bind9utils bind9-doc

echo "Configurando BIND..."
# Copiamos los ficheros de configuración desde /vagrant/config
cp /vagrant/configdns/named.conf.options /etc/bind/named.conf.options
cp /vagrant/configdns/named.conf.local /etc/bind/named.conf.local
cp /vagrant/configdns/juanma.test.dns /var/lib/bind/juanma.test.dns
cp /vagrant/configdns/juanma.test.rev /var/lib/bind/juanma.test.rev

# Asegurar permisos correctos
chown bind:bind /var/lib/bind/*.dns /var/lib/bind/*.rev

# Forzamos IPv4 solo (como dice el PDF en /etc/default/named)
sed -i 's/OPTIONS=.*/OPTIONS="-u bind -4"/' /etc/default/named

echo "Reiniciando BIND..."
systemctl restart bind9
systemctl enable named.service


echo "Instalamos Ngnix"
apt install nginx -y

echo "Instalamos Git"
apt install git -y

echo "Creamos la estroctura"
mkdir -p /var/www/juanma-davids.test/html

echo "Clonando web estática..."
if [ ! -d "/var/www/juanma-davids.test/html/css" ]; then
    git clone https://github.com/cloudacademy/static-website-example /var/www/juanma-davids.test/html
fi

echo "Asignando permisos..."
chown -R www-data:www-data /var/www/juanma-davids.test
chmod -R 755 /var/www/juanma-davids.test

echo "Creando config Nginx..."
cat > /etc/nginx/sites-available/juanma-davids.test << 'EOF'
server {
    listen 80;
    listen [::]:80;

    root /var/www/juanma-davids.test/html;
    index index.html index.htm;

    server_name juanma-davids.test;

    location / {
        try_files $uri $uri/ =404;
    }
}
EOF

echo "Activando sitio..."
ln -sf /etc/nginx/sites-available/juanma-davids.test /etc/nginx/sites-enabled/

echo "Reiniciando Nginx..."
systemctl restart nginx

