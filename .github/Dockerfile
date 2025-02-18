# Usa Ubuntu 20.04 como base
FROM --platform=linux/amd64 ubuntu:20.04

# Evita preguntas durante la instalación
ENV DEBIAN_FRONTEND=noninteractive

# Instala Java 11 y otras dependencias necesarias
RUN apt-get update && apt-get install -y \
    openjdk-11-jdk \
    wget \
    unzip \
    xvfb \
    libgbm1 \
    libnss3 \
    libxss1 \
    libasound2 \
    curl \
    gpg \
    sudo \
    libxml-commons-external-java \
    libjaxb-api-java \
    libjavax-activation-java \
    libnss3-tools \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libdrm2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxdamage1 \
    libxfixes3 \
    libxrandr2 \
    libgbm1 \
    libasound2

# Configura variables de entorno
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH
ENV DISPLAY=:99
ENV KATALON_JAVA_OPTS="-Djavax.xml.bind.context.factory=com.sun.xml.bind.v2.ContextFactory -Djava.security.egd=file:/dev/./urandom -Xmx2048m"

# Instala Chrome y sus dependencias primero
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list && \
    apt-get update && \
    apt-get install -y \
    google-chrome-stable \
    fonts-liberation \
    xdg-utils \
    dbus-x11

# Instala el último ChromeDriver estable
RUN CHROME_VERSION=$(google-chrome --version | awk '{print $3}' | awk -F'.' '{print $1}') && \
    CHROMEDRIVER_VERSION=$(curl -s "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${CHROME_VERSION}") && \
    wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/${CHROMEDRIVER_VERSION}/chromedriver_linux64.zip" && \
    unzip /tmp/chromedriver.zip -d /usr/local/bin/ && \
    rm /tmp/chromedriver.zip && \
    chmod +x /usr/local/bin/chromedriver

# Crea usuario y estructura de directorios
RUN useradd -m -s /bin/bash katalon && \
    mkdir -p /katalon/source && \
    mkdir -p /katalon/{Reports,logs} && \
    chown -R katalon:katalon /katalon && \
    chmod -R 777 /katalon && \
    chown -R katalon:katalon /opt && \
    chmod -R 777 /opt

# Configura el directorio de trabajo
WORKDIR /katalon

# Descarga e instala Katalon Runtime Engine
RUN wget -O /tmp/katalon.tar.gz "https://github.com/katalon-studio/katalon-studio/releases/download/v8.5.5/Katalon_Studio_Engine_Linux_64-8.5.5.tar.gz" && \
    mkdir -p /opt/katalon && \
    tar -xzvf /tmp/katalon.tar.gz -C /opt/katalon && \
    chmod +x /opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/katalonc && \
    ln -s /opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/katalonc /usr/local/bin/katalonc && \
    rm /tmp/katalon.tar.gz && \
    chown -R katalon:katalon /opt/katalon && \
    chmod -R 755 /opt/katalon

# Copia los archivos del proyecto y configura permisos
COPY --chown=katalon:katalon . .
COPY --chown=katalon:katalon .github/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && \
    chmod -R 777 /katalon/source

USER katalon

# Usa el script de entrada como punto de entrada
ENTRYPOINT ["/entrypoint.sh"]
