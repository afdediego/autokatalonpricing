#!/bin/bash
set -x  # Esto mostrará cada comando que se ejecuta

echo "=== VERIFICACIÓN DEL ENTORNO ==="
echo "1. Versión de Java:"
java -version

echo "2. Variables de entorno Java:"
echo "JAVA_HOME: ${JAVA_HOME}"
echo "PATH: ${PATH}"

echo "3. Estado de Xvfb:"
Xvfb :99 -screen 0 1024x768x24 &
sleep 2
ps aux | grep Xvfb

echo "4. Versión de Chrome:"
google-chrome --version

echo "5. Versión de ChromeDriver:"
chromedriver --version

echo "6. Verificación de Katalon:"
echo "Permisos del ejecutable:"
ls -l /opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/katalonc
echo "Tipo de archivo:"
file /opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/katalonc
echo "Contenido del directorio Katalon:"
find /opt/katalon -type f -ls

echo "7. Verificación del proyecto:"
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

# Ejecuta Katalon con el comando correcto
/opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/katalonc \
    -noSplash \
    -runMode=console \
    -projectPath="./Pricing-PrimeraPrueba.prj" \
    -retry=0 \
    -testSuitePath="Test Suites/PRICING-Test Plan Regresión Core" \
    -executionProfile="default" \
    -browserType="Chrome" \
    -apiKey="${KATALON_API_KEY}" \
    --config \
    -proxy.option=NO_PROXY \
    -webui.autoUpdateDrivers=true \
    -webui.chromeSwitches="--no-sandbox --disable-dev-shm-usage --headless=new --disable-gpu --window-size=1920,1080 --remote-debugging-port=9222"

# Si hay error, muestra los logs
if [ $? -ne 0 ]; then
    echo "Error en la ejecución. Mostrando logs:"
    cat /katalon/logs/katalon.log
    cat /opt/katalon/configuration/*.log
fi

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