#!/bin/bash
set -e

echo "=== INICIANDO ENTRYPOINT ==="

# Inicia Xvfb
Xvfb :99 -screen 0 1024x768x24 &
sleep 3

# Verifica las versiones instaladas
echo "=== VERSIONES INSTALADAS ==="
google-chrome --version
chromedriver --version
java -version

# Ejecuta las pruebas de Katalon
echo "=== EJECUTANDO PRUEBAS KATALON ==="
katalonc \
    -noSplash \
    -runMode=console \
    -projectPath="/katalon/source/Pricing-PrimeraPrueba.prj" \
    -retry=0 \
    -testSuiteTimeout=1800 \
    -testSuitePath="Test Suites/PRICING - Test Suite Prueba Reducida" \
    -browserType="Chrome" \
    -executionProfile="default" \
    -apiKey="${KATALON_API_KEY}" \
    -reportFolder="/katalon/source/Reports" \
    -reportFileName="katalon-results" \
    --config \
    -webui.autoUpdateDrivers=false \
    -webui.chromeSwitches="--no-sandbox --disable-dev-shm-usage --headless=new --disable-gpu --window-size=1024,768 --disable-extensions --disable-software-rasterizer --disable-popup-blocking --disable-default-apps --no-first-run --aggressive-cache-discard --disable-cache --disable-application-cache --disable-offline-load-stale-cache --disk-cache-size=0 --disable-background-networking --disable-sync --disable-translate --hide-scrollbars --metrics-recording-only --mute-audio --no-first-run --safebrowsing-disable-auto-update --ignore-certificate-errors --ignore-ssl-errors --ignore-certificate-errors-spki-list --disable-dev-tools --js-flags=--max-old-space-size=4096" \
    -webui.timeoutDefault=10 \
    -webui.waitForIEHanging=2 \
    -webui.pageLoadTimeout=20 \
    -webui.delay=0 \
    -webui.actionDelay=0 \
    -webui.batchSize=50 \
    -webui.concurrentInstances=4 \
    -webui.maxFailedTestSteps=100 \
    -webui.skipExecutingTestStepPassed=true \
    -webui.smartWaitMode=true \
    -webui.selfHealingEnabled=false \
    -webui.useActionDelayInSecond=false \
    -webui.maximizeWindow=false \
    -webui.execution.defaultFailureHandling="CONTINUE_ON_FAILURE" \
    -webui.continueOnFailure=true \
    -webui.stopTestSuiteIfFailing=false \
    -webui.abortTestSuiteOnFailure=false \
    -webui.continueOnStepFailure=true \
    -webui.timeout.pageLoad=10 \
    -webui.timeout.element=5 \
    -webui.timeout.script=5

echo "=== PRUEBAS COMPLETADAS ==="

# Generar resumen de pruebas
echo "=== RESUMEN DE EJECUCIÓN ==="
if [ -d "/katalon/source/Reports" ]; then
    echo "Tests fallidos:"
    find /katalon/source/Reports -name "*.xml" -type f -exec grep -l "<failure" {} \; | while read file; do
        testcase=$(grep "<testcase" "$file" | head -1)
        echo "- ${testcase#*name=\"}"
    done
    
    total_tests=$(find /katalon/source/Reports -name "*.xml" -type f -exec grep "<testcase" {} \; | wc -l)
    failed_tests=$(find /katalon/source/Reports -name "*.xml" -type f -exec grep "<failure" {} \; | wc -l)
    passed_tests=$((total_tests - failed_tests))
    
    echo "Total de pruebas ejecutadas: $total_tests"
    echo "Pruebas exitosas: $passed_tests"
    echo "Pruebas fallidas: $failed_tests"
fi

echo "=== VERIFICACIÓN DEL ENTORNO ==="
echo "1. Variables de entorno Java:"
echo "JAVA_HOME: ${JAVA_HOME}"
echo "PATH: ${PATH}"

echo "2. Estado de Xvfb:"
ps aux | grep Xvfb

echo "3. Verificación de Katalon:"
echo "Permisos del ejecutable:"
ls -l /opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/katalonc
echo "Tipo de archivo:"
file /opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/katalonc
echo "Contenido del directorio Katalon:"
find /opt/katalon -type f -ls

echo "4. Verificación del proyecto:"
echo "Contenido del directorio actual:"
pwd
ls -la .
echo "Contenido de /katalon/source:"
ls -la /katalon/source/

# Verifica la existencia del archivo .prj
ls -la /katalon/source/

# Verifica las variables de entorno
echo "KATALON_API_KEY está definido: ${KATALON_API_KEY:+true}"

# Verifica qué directorio existe y su contenido
ls -la /katalon/source/
if [ -d "/katalon/source/autokatalonpricing-main" ]; then
    PROJECT_DIR="/katalon/source/autokatalonpricing-main"
elif [ -d "/katalon/source/autokatalonpricing" ]; then
    PROJECT_DIR="/katalon/source/autokatalonpricing"
else
    PROJECT_DIR="/katalon/source"
fi

# Configura el entorno para Chrome
export DBUS_SESSION_BUS_ADDRESS=/dev/null

# Verifica la instalación de Katalon
echo "Verificando instalación de Katalon:"
ls -la /opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/

# Configuración adicional para Chrome
export CHROME_BIN=/usr/bin/google-chrome
export CHROME_PATH=/usr/bin/google-chrome
export DISPLAY=:99

# Muestra información de depuración
echo "Contenido del directorio actual:"
pwd
ls -la
echo "Variables de entorno:"
env | grep GITHUB
echo "Contenido de /katalon/source:"
ls -la /katalon/source/
echo "Contenido de ${PROJECT_DIR}:"
ls -la ${PROJECT_DIR}

echo "=== VERIFICACIÓN DETALLADA DEL MONTAJE ==="
echo "1. Contenido de github.workspace:"
echo "${{ github.workspace }}"
echo "2. Contenido actual:"
find /katalon/source -type f
echo "3. Permisos del directorio:"
ls -la /katalon
echo "4. Permisos del archivo .prj:"
find /katalon/source -name "*.prj" -ls 