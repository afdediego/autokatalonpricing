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
    libasound2 \
    libgconf-2-4 \
    libappindicator1

# Configura variables de entorno
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH
ENV DISPLAY=:99
ENV KATALON_JAVA_OPTS="-Djavax.xml.bind.context.factory=com.sun.xml.bind.v2.ContextFactory -Djava.security.egd=file:/dev/./urandom -Xmx2048m"

# Instala dependencias necesarias para añadir el repositorio de Chrome
RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    && rm -rf /var/lib/apt/lists/*

# Añade el repositorio de Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list

# Instala Chrome y sus dependencias
RUN apt-get update && apt-get install -y \
    google-chrome-stable \
    fonts-liberation \
    xdg-utils \
    dbus-x11 \
    libgconf-2-4 \
    libappindicator1 \
    libnss3-tools && \
    mkdir -p /etc/opt/chrome/policies/managed && \
    echo '{ "CommandLineFlagSecurityWarningsEnabled": false }' > /etc/opt/chrome/policies/managed/managed_policies.json

# Instala el último ChromeDriver estable
RUN CHROME_MAJOR_VERSION=$(google-chrome --version | awk '{print $3}' | awk -F'.' '{print $1}') && \
    echo "Chrome Major Version: $CHROME_MAJOR_VERSION" && \
    CHROMEDRIVER_VERSION=$(curl -sS "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_$CHROME_MAJOR_VERSION") && \
    echo "ChromeDriver Version: $CHROMEDRIVER_VERSION" && \
    wget -O /tmp/chromedriver.zip "https://storage.googleapis.com/chrome-for-testing-public/$CHROMEDRIVER_VERSION/linux64/chromedriver-linux64.zip" && \
    unzip /tmp/chromedriver.zip -d /tmp/ && \
    mv /tmp/chromedriver-linux64/chromedriver /usr/local/bin/ && \
    rm -rf /tmp/chromedriver.zip /tmp/chromedriver-linux64 && \
    chmod +x /usr/local/bin/chromedriver && \
    chromedriver --version

# Crea usuario y estructura de directorios
RUN useradd -m -s /bin/bash katalon && \
    mkdir -p /katalon/source && \
    mkdir -p /katalon/{Reports,logs} && \
    chown -R katalon:katalon /katalon && \
    chmod -R 777 /katalon && \
    chown -R katalon:katalon /opt && \
    chmod -R 777 /opt

# Configura el directorio de trabajo
WORKDIR /katalon/source

# Descarga e instala Katalon Runtime Engine
RUN wget -O /tmp/katalon.tar.gz "https://github.com/katalon-studio/katalon-studio/releases/download/v8.5.5/Katalon_Studio_Engine_Linux_64-8.5.5.tar.gz" && \
    mkdir -p /opt/katalon && \
    tar -xzvf /tmp/katalon.tar.gz -C /opt/katalon && \
    echo "Contenido del directorio Katalon:" && \
    ls -la /opt/katalon && \
    echo "Contenido del directorio específico:" && \
    ls -la /opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/ && \
    echo "Contenido del script katalonc:" && \
    cat /opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/katalonc && \
    chmod +x /opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/katalonc && \
    ln -s /opt/katalon/Katalon_Studio_Engine_Linux_64-8.5.5/katalonc /usr/local/bin/katalonc && \
    rm /tmp/katalon.tar.gz && \
    chown -R katalon:katalon /opt/katalon && \
    chmod -R 755 /opt/katalon

# Copia los archivos del proyecto y configura permisos
COPY --chown=katalon:katalon . /katalon/source/
COPY --chown=katalon:katalon .github/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh && \
    chmod -R 777 /katalon/source

# Configura permisos adicionales para Chrome
RUN mkdir -p /var/run/chrome && \
    chown -R katalon:katalon /var/run/chrome && \
    chmod -R 777 /var/run/chrome

USER katalon

# Usa el script de entrada como punto de entrada
ENTRYPOINT ["/entrypoint.sh"]
