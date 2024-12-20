# Usa la imagen base oficial de Katalon Studio
FROM katalonstudio/katalon:latest

# Configura el directorio de trabajo dentro del contenedor
WORKDIR /katalon/katalon/source

# Copia los archivos del proyecto al contenedor
COPY . .

# Instala OpenVPN para la conexión a la VPN
RUN apt-get update && apt-get install -y openvpn

# Copia el archivo de configuración de la VPN al contenedor
COPY .github/config.ovpn /etc/openvpn/config.ovpn

# Ejecuta OpenVPN al iniciar el contenedor
CMD openvpn --config /etc/openvpn/config.ovpn & \
    sleep 10 && \
    curl -I http://example.com && \
    if [ -f /katalon/katalon/source/Pricing-PrimeraPrueba.prj ]; then \
        katalon -noSplash -runMode=console \
        -projectPath=/katalon/katalon/source/Pricing-PrimeraPrueba.prj \
        -testSuitePath="Test Suites/PRICING-Test Plan Regresión Core" \
        -browserType="Chrome (headless)"; \
    else \
        echo "Project file not found"; \
        exit 1; \
    fi
