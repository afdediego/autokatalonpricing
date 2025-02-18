#!/bin/bash

# Configura la VPN usando FortiClient CLI
echo "Configurando VPN..."
cat > /tmp/vpn_config.txt << EOF
set server vpn.recordgo.com:32444
set username ext_adiego@primeit.es
set password ${VPN_PASSWORD}
connect
EOF

# Inicia la VPN
forticlientsslvpn_cli --file=/tmp/vpn_config.txt &

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