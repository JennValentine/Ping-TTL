#!/bin/bash
#====================================================
#   SCRIPT:                   PING TTL
#   DESARROLLADO POR:         JENN VALENTINE 
#   FECHA DE ACTUALIZACI�N:   16-03-2024 
#   CONTACTO POR TELEGRAMA:   https://t.me/JennValentine
#   GITHUB OFICIAL:           https://github.com/JennValentine/Ping-TTL
#====================================================

# Paleta de colores
reset="\033[0m"       # Restablecer todos los estilos y colores
bold="\033[1m"        # Texto en negrita
italic="\033[3m"      # Texto en cursiva
underline="\033[4m"   # Texto subrayado
blink="\033[5m"       # Texto parpadeante
reverse="\033[7m"     # Invertir colores de fondo y texto
hidden="\033[8m"      # Texto oculto (generalmente invisible)

# Colores de texto
black="\033[0;30m"     # Negro
red="\033[0;31m"       # Rojo
green="\033[0;32m"     # Verde
yellow="\033[0;33m"    # Amarillo
blue="\033[0;34m"      # Azul
magenta="\033[0;35m"   # Magenta
cyan="\033[0;36m"      # Cian
white="\033[0;37m"     # Blanco

# Colores de fondo
bg_black="\033[0;40m"     # Fondo Negro
bg_red="\033[0;41m"       # Fondo Rojo
bg_green="\033[0;42m"     # Fondo Verde
bg_yellow="\033[0;43m"    # Fondo Amarillo
bg_blue="\033[0;44m"      # Fondo Azul
bg_magenta="\033[0;45m"   # Fondo Magenta
bg_cyan="\033[0;46m"      # Fondo Cian
bg_white="\033[0;47m"     # Fondo Blanco

# Iconos
checkmark="${green}[++]${reset}"
error="${red}[--]${reset}"
info="${yellow}[**]${reset}"
process="${magenta}[>>]${reset}"
indicator="${red}==>${reset}"

# Barra de separaci�n
barra="${blue}|--------------------------------------------|${reset}"
bar="${yellow}--------------------------------------------${reset}"

# Funci�n para determinar el sistema operativo en funci�n del valor de TTL
tipe_ttl() {
    ip=$1
    ttl=$2
    if [ $ttl -le 64 ] && [ $ttl -ge 1 ]; then
        os="Posiblemente Linux/Unix"
    elif [ $ttl -ge 65 ] && [ $ttl -le 128 ]; then
        os="Posiblemente Windows"
    elif [ $ttl -ge 129 ] && [ $ttl -le 191 ]; then
        os="Posiblemente macOS"
    elif [ $ttl -ge 192 ] && [ $ttl -le 254 ]; then
        os="Posiblemente Cisco IOS"
    else
        os="Sistema desconocido"
    fi
    echo -e "\n${info} ${green} Extrayendo informaci�n...\n"
    echo -e "\t${indicator} ${green}Direcci�n:              ${white}$ip"
    echo -e "\t${indicator} ${green}Tiempo de Vida:         ${white}$ttl"
    echo -e "\t${indicator} ${green}Sistema Operativo:      ${yellow}$os"
    echo -e "\n${white}Valores de TTL: 1-64 (Linux/Unix), 65-128 (Windows), 129-191 (macOS), 192-254 (Cisco IOS)."
    echo -e "\n${info} ${white}GITHUB OFICIAL: ${green}https://github.com/JennValentine/Ping-TTL\n"
    echo -e "$barra"
    exit 0
}

# Verificar si se proporcion� un �nico argumento
if [ $# -eq 1 ]; then
    # Obtener el valor de TTL del resultado del ping al host
    ttl=$(timeout 4 bash -c "ping -c1 $1 | grep -oP 'ttl=\d{1,3}' | cut -d '=' -f 2" 2>/dev/null)
    # Verificar si el comando ping tuvo �xito y el valor de TTL es v�lido
    if [ $? -eq 0 ] && [ "$ttl" -le 255 ] && [ "$ttl" -ge 1 ] 2>/dev/null; then
        # Llamar a la funci�n tipe_ttl() para determinar el sistema operativo
        tipe_ttl $1 $ttl
    fi
    # Mostrar mensaje de error si el ping fall� o el TTL es inv�lido
    echo -e "\n${error} ERROR: �Par�metro inv�lido o no se puede alcanzar el host!"
else
    # Mostrar el modo de uso si no se proporcion� un �nico argumento
    echo -e "\n${green}PING TTL"
    echo -e "\n${green}Uso:${reset}\n"
    echo -e "${white}  Ejemplo con IP:${reset}\t\t${green}pttl 8.8.8.8"
    echo -e "${white}  Ejemplo con dominio:${reset}\t\t${green}pttl google.com"
    echo -e "\n${info} ${white}GITHUB OFICIAL: ${green}https://github.com/JennValentine/Ping-TTL\n"
    echo -e "$barra"
fi

# Fin del script
