# Usa la imagen base de Eclipse Temurin 8
FROM --platform=linux/amd64 eclipse-temurin:8-jdk

# Evita preguntas durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    xvfb \
    libgbm1 \
    libnss3 \
    libxss1 \
    libasound2 \
    chromium \
    curl \
    gpg \
    openvpn

# Configura variables de entorno
ENV DISPLAY=:99
ENV KATALON_JAVA_OPTS="-Djavax.xml.bind.context.factory=com.sun.xml.bind.v2.ContextFactory -Djava.security.egd=file:/dev/./urandom -Xmx2048m"

# Descarga e instala Katalon Runtime Engine (versión 7.5.5)
RUN wget https://github.com/katalon-studio/katalon-studio/releases/download/v7.5.5/Katalon_Studio_Engine_Linux_64-7.5.5.tar.gz -O katalon.tar.gz && \
    tar -xzvf katalon.tar.gz -C /opt/ && \
    chmod +x /opt/Katalon_Studio_Engine_Linux_64-7.5.5/katalonc && \
    ln -s /opt/Katalon_Studio_Engine_Linux_64-7.5.5/katalonc /usr/local/bin/katalonc && \
    rm katalon.tar.gz

# Crea directorio para logs
RUN mkdir -p /katalon/logs && chmod 777 /katalon/logs

# Configura el directorio de trabajo
WORKDIR /katalon/katalon

# Copia los archivos del proyecto
COPY . .

# Crea el script de entrada
COPY .github/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Usa el script de entrada como punto de entrada
ENTRYPOINT ["/entrypoint.sh"]
