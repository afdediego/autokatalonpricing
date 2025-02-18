# Usa la imagen base oficial de Ubuntu
FROM ubuntu:latest

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    unzip \
    xvfb \
    libgbm1 \
    libnss3 \
    libxss1 \
    libasound2t64 \
    chromium-browser \
    curl \
    gpg \
    openvpn

# Descarga e instala Katalon
RUN wget https://github.com/katalon-studio/katalon-studio/releases/download/v8.5.5/Katalon_Studio_Linux_64-8.5.5.tar.gz -O katalon.tar.gz && \
    tar -xzvf katalon.tar.gz -C /opt/ && \
    chmod +x /opt/Katalon_Studio_Linux_64-8.5.5/katalonc && \
    ln -s /opt/Katalon_Studio_Linux_64-8.5.5/katalonc /usr/local/bin/katalon

# Configura el directorio de trabajo
WORKDIR /katalon/katalon

# Copia los archivos del proyecto
COPY . .

# Crea el script de entrada
COPY .github/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Usa el script de entrada como punto de entrada
ENTRYPOINT ["/entrypoint.sh"]
