#!/bin/bash
#====================================================
#   SCRIPT:                   PING TTL
#   DESARROLLADO POR:         JENN VALENTINE 
#   FECHA DE ACTUALIZACIÃ“N:  16-03-2024 
#   CONTACTO POR TELEGRAMA:   https://t.me/JennValentine
#   GITHUB OFICIAL:           https://github.com/JennValentine/Ping-TTL
#====================================================

# Paleta de colores
reset="\033[0m"       # Restablecer todos los estilos y colores

# Colores de texto
black="\033[0;30m"     # Negro
red="\033[0;31m"       # Rojo
green="\033[0;32m"     # Verde
yellow="\033[0;33m"    # Amarillo
blue="\033[0;34m"      # Azul
magenta="\033[0;35m"   # Magenta
cyan="\033[0;36m"      # Cian
white="\033[0;37m"     # Blanco

checkmark="${green}[++]${reset}"
error="${red}[--]${reset}"
info="${yellow}[**]${reset}"
process="${magenta}[>>]${reset}"

barra="${blue}|--------------------------------------------|${reset}"

# Obtiene el valor de TTL del resultado de ping al host en $1
ttl=$(timeout 4 bash -c "ping -c1 $1 | grep -oP 'ttl=\d{1,3}' | cut -d '=' -f 2" 2>/dev/null)

# Función para determinar el sistema operativo en función del valor de TTL
function tipe_ttl ()
{
    ip=$1
    ttl=$2
    if [ $ttl -le 64 -a $ttl -ge 1 ]; then
        echo -e "\n\033[01;33m[**] Extracting information...\n"
        echo -e "\t\033[01;32m>> Host: $ip"
        echo -e "\t\033[01;32m>> TTL: $ttl"
        echo -e "\t\033[01;32m>> OS: \033[01;33mPossibly Linux System"
        echo -e "\n\033[1;32m[++] Information Successfully\n"
    elif [ $ttl -ge 65 -a $ttl -le 128 ]; then
        echo -e "\n\033[01;33m[**] Extracting information...\n"
        echo -e "\t\033[01;32m>> Host: $ip"
        echo -e "\t\033[01;32m>> TTL: $ttl"
        echo -e "\t\033[01;32m>> OS: \033[01;33mPossibly Windows System"
        echo -e "\n\033[1;32m[++] Information Successfully\n"
    elif [ $ttl -ge 129 -a $ttl -le 255 ]; then
        echo -e "\n\033[01;33m[**] Extracting information...\n"
        echo -e "\t\033[01;32m>> Host: $ip"
        echo -e "\t\033[01;32m>> TTL: $ttl"
        echo -e "\t\033[01;32m>> OS: \033[01;33mPossibly macOS System"
        echo -e "\n\033[1;32m[++] Information Successfully\n"
    elif [ $ttl -ge 256 -a $ttl -le 512 ]; then
        echo -e "\n\033[01;33m[**] Extracting information...\n"
        echo -e "\t\033[01;32m>> Host: $ip"
        echo -e "\t\033[01;32m>> TTL: $ttl"
        echo -e "\t\033[01;32m>> OS: \033[01;33mPossibly Cisco IOS"
        echo -e "\n\033[1;32m[++] Information Successfully\n"
    else
        echo -e "\n\033[01;33m[**] Extracting information...\n"
        echo -e "\t\033[01;32m>> Unknown System\n"
        echo -e "\n\033[1;31m[--] Information not available\n"
    fi
    exit 0
}

# Comprobar si se proporcionó un único argumento
if [ $# -eq 1 ]; then
    # Verificar si el comando ping tuvo éxito y el valor de TTL es válido
    if [ $? -eq 0 -a $ttl -le 512 -a $ttl -ge 1 ] 2>/dev/null; then
        tipe_ttl $1 $ttl
    fi
    echo -e "\n\033[1;31m[--] ERROR, coloque un parámetro válido"
    echo -e "\033[1;31m    o verifique si el host está activo!\n"
    exit 1
else
    echo -e "\n\033[01;33m[**] EL modo de uso es:\n"
    echo -e "\t\033[01;37m Ejemplo con IP         \033[01;32m$0 8.8.8.8    | \033[01;32mpttl 8.8.8.8"
    echo -e "\t\033[01;37m Ejemplo con dominio    \033[01;32m$0 google.com | \033[01;32mpttl google.com\n"
    echo -e " \033[0;32mPing TTL v1.0\n"
fi

# Fin del script

