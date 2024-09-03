![logo](https://steamuserimages-a.akamaihd.net/ugc/2431257904741262239/5224F69217562A3C070E381FE3DAC295BCF5C9A8/?imw=1024&imh=575&ima=fit&impolicy=Letterbox&imcolor=%23000000&letterbox=true)

# Ping-TTL :octocat: 

## :information_source: Descripción
Este script Bash realiza un ping a un host proporcionado como argumento y extrae 
información sobre su sistema operativo basándose en el valor de TTL (Time To Live) 
del ping. Aunque es una herramienta simple, ofrece una estimación del sistema operativo 
del host. Es importante tener en cuenta que la precisión de esta identificación 
puede variar, ya que el TTL no garantiza una identificación 
exacta del sistema operativo.

## :computer: Instalación
```bash
cd /opt
sudo rm -rf Ping-TTL
sudo git clone https://github.com/JennValentine/Ping-TTL
sudo chmod +x Ping-TTL/*
cd Ping-TTL
ls -lthas
```

## :key: Acceso Directo
```bash
cd /opt/Ping-TTL
sudo cp pttl.sh pttl_$RANDOM.sh
sudo mv pttl.sh pttl
sudo rm -rf /usr/local/bin/pttl
sudo mv pttl /usr/local/bin/
ls -lthas
cd
```

## :computer: Instalación en una Línea
```bash
wget https://raw.githubusercontent.com/JennValentine/Ping-TTL/main/install.sh; sudo chmod +x install.sh; sudo ./install.sh; sudo rm -rf install.sh
```

## :rocket: Modo de Uso

Ejecute el script escribiendo una dirección `IP` o `dominio` en tu terminal y presionando Enter.

```bash
pttl 8.8.8.8
```

![logo](https://github.com/JennValentine/Ping-TTL/blob/main/Imagenes/pttl-8_8_8_8.jpg)
:memo: Esto enviará un paquete de ping a la dirección IP 8.8.8.8 y tratará de determinar el sistema operativo basándose en el valor de TTL.

```bash
pttl google.com
```
![logo](https://github.com/JennValentine/Ping-TTL/blob/main/Imagenes/pttl-google_com.jpg)
:memo: Similar al primer ejemplo, pero usando un nombre de dominio (google.com en este caso).

## :bulb: Sugerencia  

Ejecutar el script sin argumentos para ver el modo de uso:

```bash
pttl
```
![logo](https://github.com/JennValentine/Ping-TTL/blob/main/Imagenes/pttl-help.jpg)
:memo: Muestra un mensaje explicando cómo usar el script, incluyendo ejemplos.

## :star2: Características 

- Automatización: Simplifica el proceso de identificación del sistema operativo basado en el TTL.
- Simplicidad: Ofrece una interfaz fácil de usar con comandos sencillos.
- Flexibilidad: Soporta tanto direcciones IP como nombres de dominio.

## :hammer_and_wrench: Requisitos 

- Sistema Operativo: Linux/Unix
- Dependencias: Bash

## :open_file_folder: Estructura del Repositorio

```plaintext
Ping-TTL/
│
├── Imagenes/            # Carpeta que contiene imágenes de ejemplos y del script en ejecución.
│   ├── pttl-8_8_8_8.jpg
│   ├── pttl-google_com.jpg
│   └── pttl-help.jpg
│
├── LICENSE              # Licencia MIT para el proyecto.
│
├── README.md            # Archivo README con la documentación del proyecto.
│
├── install.sh           # Script de instalación automática.
│
└── pttl.sh              # Script principal que realiza el ping y estima el SO.
```

## :email: Contacto
* :busts_in_silhouette: [Jenn Valentine](https://t.me/JennValentine) - Contribución
