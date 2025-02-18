#!/bin/bash
set -x  # Esto mostrará cada comando que se ejecuta

# Inicia Xvfb en segundo plano y espera a que esté listo
Xvfb :99 -screen 0 1024x768x24 &
sleep 2

# Verifica la existencia del archivo .prj
ls -la /katalon/source/

# Verifica las variables de entorno
echo "KATALON_API_KEY está definido: ${KATALON_API_KEY:+true}"

# Verifica qué directorio existe
if [ -d "/katalon/source/autokatalonpricing-main" ]; then
    PROJECT_DIR="/katalon/source/autokatalonpricing-main"
else
    PROJECT_DIR="/katalon/source/autokatalonpricing"
fi

# Ejecuta Katalon con el comando correcto
/opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/katalonc \
    -noSplash \
    -runMode=console \
    -projectPath="${PROJECT_DIR}/Pricing-PrimeraPrueba.prj" \
    -retry=0 \
    -testSuitePath="Test Suites/PRICING-Test Plan Regresión Core" \
    -executionProfile="default" \
    -browserType="Chrome (headless)" \
    -apiKey="${KATALON_API_KEY}" \
    --config \
    -proxy.option=NO_PROXY \
    -webui.autoUpdateDrivers=true \
    -webui.chromeSwitches="--no-sandbox --disable-dev-shm-usage --headless --disable-gpu"

# Si hay error, muestra los logs
if [ $? -ne 0 ]; then
    echo "Error en la ejecución. Mostrando logs:"
    cat /katalon/logs/katalon.log
    cat /opt/katalon/configuration/*.log
fi 