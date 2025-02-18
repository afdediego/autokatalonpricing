#!/bin/bash
set -x  # Esto mostrará cada comando que se ejecuta

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

# Verifica la existencia del archivo .prj
ls -la /katalon/katalon/source/

# Verifica las variables de entorno (ocultando valores sensibles)
echo "VPN_PASSWORD está definido: ${VPN_PASSWORD:+true}"
echo "KATALON_API_KEY está definido: ${KATALON_API_KEY:+true}"

# Ejecuta Katalon con el comando correcto y las variables de entorno de Java
JAVA_OPTS="${KATALON_JAVA_OPTS}" \
/opt/Katalon_Studio_Engine_Linux_64-7.5.5/katalonc \
    -noSplash \
    -runMode=console \
    -projectPath="/katalon/katalon/source/Pricing-PrimeraPrueba.prj" \
    -retry=0 \
    -testSuitePath="Test Suites/PRICING-Test Plan Regresión Core" \
    -executionProfile="default" \
    -browserType="Chrome (headless)" \
    -apiKey="${KATALON_API_KEY}" \
    --config \
    -proxy.option=NO_PROXY \
    -webui.autoUpdateDrivers=true

# Si hay error, muestra los logs
if [ $? -ne 0 ]; then
    echo "Error en la ejecución. Mostrando logs:"
    cat /katalon/logs/katalon.log
    cat /opt/Katalon_Studio_Engine_Linux_64-7.5.5/configuration/*.log
fi 