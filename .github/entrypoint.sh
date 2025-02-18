#!/bin/bash

# Configura OpenVPN
echo "Configurando VPN..."
cat > /etc/openvpn/client.conf << EOF
client
dev tun
proto tcp
remote vpn.recordgo.com 32444
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-CBC
auth SHA256
verb 3
auth-user-pass /etc/openvpn/auth.txt
EOF

# Configura las credenciales
echo "ext_adiego@primeit.es" > /etc/openvpn/auth.txt
echo "${VPN_PASSWORD}" >> /etc/openvpn/auth.txt

# Inicia OpenVPN en segundo plano
openvpn --config /etc/openvpn/client.conf --daemon

# Espera a que la VPN se establezca
sleep 10

# Inicia Xvfb en segundo plano
Xvfb :99 -screen 0 1024x768x24 &
export DISPLAY=:99

# Ejecuta Katalon
katalon -noSplash -runMode=console \
    -projectPath="/katalon/katalon/source/Pricing-PrimeraPrueba.prj" \
    -testSuitePath="Test Suites/PRICING-Test Plan Regresión Core" \
    -browserType="Chrome (headless)" 