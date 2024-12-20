# Usa la imagen base de Ubuntu
FROM ubuntu:latest

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    unzip \
    openvpn

# Descarga e instala Katalon Studio
RUN wget https://github.com/katalon-studio/katalon-studio/releases/download/v8.5.5/Katalon_Studio_Linux_64-8.5.5.tar.gz -O katalon.tar.gz && \
    tar -xvzf katalon.tar.gz -C /opt/ && \
    ln -s /opt/Katalon_Studio_Linux_64-8.5.5/katalonc /usr/bin/katalon && \
    rm katalon.tar.gz

# Configura el directorio de trabajo dentro del contenedor
WORKDIR /katalon/katalon/source

# Copia los archivos del proyecto al contenedor
COPY . .

# Copia el archivo de configuración de la VPN al contenedor
COPY .github/config.ovpn /etc/openvpn/config.ovpn

# Ejecuta OpenVPN y Katalon al iniciar el contenedor
CMD openvpn --config /etc/openvpn/config.ovpn & \
    if [ -x /usr/bin/katalon ]; then \
        /usr/bin/katalon -noSplash -runMode=console \
        -projectPath="/katalon/katalon/source/Pricing-Test Plan de Regresión.prj" \
        -testSuitePath="Test Suites/PRICING-Test Plan Regresión Core" \
        -browserType="Chrome (headless)"; \
    else \
        echo "Error: Katalon no está instalado correctamente o no es ejecutable" && exit 1; \
    fi
