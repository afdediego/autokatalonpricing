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

# Ejecuta OpenVPN y valida las rutas necesarias antes de ejecutar Katalon
CMD if [ ! -f /etc/openvpn/config.ovpn ]; then \
        echo "Archivo de configuración VPN no encontrado" && exit 1; \
    fi && \
    if [ ! -f /katalon/katalon/source/Pricing-PrimeraPrueba.prj ]; then \
        echo "El archivo del proyecto no se encuentra en la ruta especificada" && exit 1; \
    fi && \
    if command -v katalon > /dev/null 2>&1; then \
        openvpn --config /etc/openvpn/config.ovpn & \
        katalon -noSplash -runMode=console \
        -projectPath=/katalon/katalon/source/Pricing-PrimeraPrueba.prj \
        -testSuitePath="Test Suites/PRICING-Test Plan Regresión Core" \
        -browserType="Chrome (headless)"; \
    else \
        echo "Katalon no está disponible o es un directorio" && exit 126; \
    fi
