![logo](https://github.com/JennValentine/Ping-TTL/blob/main/Imagenes/Ping-TTL.jpg)

# Ping-TTL

## Descripción
Este script Bash se encarga de realizar un ping a un host proporcionado 
como argumento y extraer información sobre el sistema operativo del 
host basándose en el valor de TTL (Time To Live) del resultado del ping. 

## :book: Instalacion
```bash
cd /opt
sudo rm -rf Ping-TTL
sudo git clone https://github.com/JennValentine/Ping-TTL
sudo chmod +x Ping-TTL/*
cd Ping-TTL
```

## :book: Acceso directo
```bash
sudo cp pttl.sh pttl_$RANDOM.sh
sudo cp pttl.sh pttl
sudo rm -rf /usr/local/bin/pttl
sudo mv pttl /usr/local/bin/
cd
```

## :book: Acceso directo (En caso de error)
```bash
cd
echo "cd /opt/Ping-TTL && sudo ./pttl.sh" > pttl
sudo chmod +x pttl
sudo rm -rf /usr/local/bin/pttl
sudo mv pttl /usr/local/bin/
cd
```

## Modo de Uso

Ejecutar el script con una dirección IP:

```bash
pttl 8.8.8.8
```
Esto enviará un paquete de ping a la dirección IP 8.8.8.8 y tratará de 
determinar el sistema operativo basándose en el valor de TTL.

Ejecutar el script con un nombre de dominio:

```bash
pttl google.com
```
Similar al primer ejemplo, pero usando un nombre de dominio 
(google.com en este caso).

Ejecutar el script sin argumentos (para ver el modo de uso):

```bash
pttl
```
Muestra un mensaje explicando cómo usar el script, incluyendo ejemplos.

DATA: Este script es una herramienta simple que proporciona una estimación 
del sistema operativo basándose en el TTL del ping. Ten en cuenta que 
esta estimación puede no ser precisa en todos los casos, ya que el valor 
de TTL puede variar y no garantiza la identificación precisa del sistema 
operativo.

## :octocat: Créditos
1. [Jenn Valentine](https://t.me/JennValentine) - Update Contributor
