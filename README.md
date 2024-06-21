![logo](https://edteam-media.s3.amazonaws.com/blogs/big/2ab53939-9b50-47dd-b56e-38d4ba3cc0f0.png)

# Ping-TTL

## :information_source: Descripción
Este script Bash se encarga de realizar un ping a un host proporcionado 
como argumento y extraer información sobre el sistema operativo del 
host basándose en el valor de TTL (Time To Live) del resultado del ping. 

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
cd
```

## :rocket: Modo de Uso

Ejecutar el script con una dirección IP:

```bash
pttl 8.8.8.8
```
![logo](https://github.com/JennValentine/Ping-TTL/blob/main/Imagenes/pttl-8_8_8_8.jpg)
:memo: Notas: Esto enviará un paquete de ping a la dirección IP 8.8.8.8 y tratará de 
determinar el sistema operativo basándose en el valor de TTL.

Ejecutar el script con un nombre de dominio:

```bash
pttl google.com
```
![logo](https://github.com/JennValentine/Ping-TTL/blob/main/Imagenes/pttl-google_com.jpg)
:memo: Notas: Similar al primer ejemplo, pero usando un nombre de dominio 
(google.com en este caso).

## Sugerencia :bulb: 

Ejecutar el script sin argumentos (para ver el modo de uso):

```bash
pttl
```
![logo](https://github.com/JennValentine/Ping-TTL/blob/main/Imagenes/pttl-help.jpg)
:memo: Notas: Muestra un mensaje explicando cómo usar el script, incluyendo ejemplos.

:bookmark_tabs: Este script es una herramienta simple que proporciona una estimación 
del sistema operativo basándose en el TTL del ping. Ten en cuenta que 
esta estimación puede no ser precisa en todos los casos, ya que el valor 
de TTL puede variar y no garantiza la identificación precisa del sistema 
operativo.

## :email: Contacto
* :busts_in_silhouette: [Jenn Valentine](https://t.me/JennValentine) - Contribución :octocat: