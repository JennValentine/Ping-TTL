#!/bin/bash
#====================================================
#   SCRIPT:                   PING TTL
#   DESARROLLADO POR:         JENN VALENTINE 
#   FECHA DE ACTUALIZACIÓN:   16-03-2024 
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

# Iconos
checkmark="${green}[++]${reset}"
error="${red}[--]${reset}"
info="${yellow}[**]${reset}"
process="${magenta}[>>]${reset}"
indicator="${red}==>${reset}"

# Barra de separación
barra="${blue}|--------------------------------------------|${reset}"

# Función para determinar el sistema operativo en función del valor de TTL
tipe_ttl() {
    ip=$1
    ttl=$2
    if [ $ttl -le 64 -a $ttl -ge 1 ]; then
        os="Possibly Linux/Unix System"
    elif [ $ttl -ge 65 -a $ttl -le 128 ]; then
        os="Possibly Windows System"
    elif [ $ttl -ge 129 -a $ttl -le 191 ]; then
        os="Possibly macOS System"
    elif [ $ttl -ge 192 -a $ttl -le 254 ]; then
        os="Possibly Cisco IOS"
    else
        os="Unknown System"
    fi
    echo -e "\n${info} ${green} Extracting information...\n"
    echo -e "\t${indicator} ${green}Host:     ${white}$ip"
    echo -e "\t${indicator} ${green}TTL:      ${white}$ttl"
    echo -e "\t${indicator} ${green}OS:       ${yellow}$os"
    echo -e "\n${white}TTL values: 1-64 (Linux/Unix), 65-128 (Windows), 129-191 (macOS), 192-254 (Cisco IOS)."
    echo -e "\n${info} ${white}GITHUB OFICIAL: ${green}https://github.com/JennValentine/Ping-TTL\n"
    exit 0
}

# Verificar si se proporcionó un único argumento
if [ $# -eq 1 ]; then
    # Obtener el valor de TTL del resultado del ping al host
    ttl=$(timeout 4 bash -c "ping -c1 $1 | grep -oP 'ttl=\d{1,3}' | cut -d '=' -f 2" 2>/dev/null)
    # Verificar si el comando ping tuvo éxito y el valor de TTL es válido
    if [ $? -eq 0 ] && [ $ttl -le 512 ] && [ $ttl -ge 1 ] 2>/dev/null; then
        # Llamar a la función tipe_ttl() para determinar el sistema operativo
        tipe_ttl $1 $ttl
    fi
    # Mostrar mensaje de error si el ping falló o el TTL es inválido
    echo -e "\n${error} ERROR: Invalid parameter or unable to reach the host!"
else
    # Mostrar el modo de uso si no se proporcionó un único argumento
    echo -e "\n${info} ${green} USAGE:\n"
    echo -e "\t${white} Example with IP:       ${green}$0 8.8.8.8    | ${green}pttl 8.8.8.8"
    echo -e "\t${white} Example with domain:   ${green}$0 google.com | ${green}pttl google.com"
fi

# Fin del script
