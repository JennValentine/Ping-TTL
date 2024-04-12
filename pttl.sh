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

# Obtiene el valor de TTL del resultado de ping al host en $1
ttl=$(timeout 4 bash -c "ping -c1 $1 | grep -oP 'ttl=\d{1,3}' | cut -d '=' -f 2" 2>/dev/null)

# Función para determinar el sistema operativo en función del valor de TTL
function tipe_ttl ()
{
    ip=$1
    ttl=$2
    if [ $ttl -le 64 -a $ttl -ge 1 ]; then
        # Sistema Linux
        echo -e "\n${info} ${green} Extracting information...\n"
        echo -e "\t${indicator} ${green}Host:     ${white}$ip"
        echo -e "\t${indicator} ${green}TTL:      ${white}$ttl"
        echo -e "\t${indicator} ${green}OS:       ${yellow}Possibly Linux System"
        echo -e "\n${white}TTL de 1 a 64: Generalmente asociado con sistemas Linux y sistemas basados en Unix."
        echo -e "\n${yellow}${info} ${white}GITHUB OFICIAL: ${green}https://github.com/JennValentine/Ping-TTL\n"
    elif [ $ttl -ge 65 -a $ttl -le 128 ]; then
        # Sistema Windows
        echo -e "\n${info} ${green} Extracting information...\n"
        echo -e "\t${indicator} ${green}Host:     ${white}$ip"
        echo -e "\t${indicator} ${green}TTL:      ${white}$ttl"
        echo -e "\t${indicator} ${green}OS:       ${yellow}Possibly Windows System"
        echo -e "\n${white}TTL de 65 a 128: Suelen indicar sistemas Windows."
        echo -e "\n${yellow}${info} ${white}GITHUB OFICIAL: ${green}https://github.com/JennValentine/Ping-TTL\n"
    elif [ $ttl -ge 129 -a $ttl -le 191 ]; then
        # Posiblemente sistema macOS
        echo -e "\n${info} ${green} Extracting information...\n"
        echo -e "\t${indicator} ${green}Host:     ${white}$ip"
        echo -e "\t${indicator} ${green}TTL:      ${white}$ttl"
        echo -e "\t${indicator} ${green}OS:       ${yellow}Possibly macOS System"
        echo -e "\n${white}TTL de 129 a 191: Puede estar asociado con sistemas macOS, pero ten en cuenta que macOS\n y sistemas Unix pueden tener TTL en el rango de 1 a 64, así que esto es más una suposición."
        echo -e "\n${info} ${white}GITHUB OFICIAL: ${green}https://github.com/JennValentine/Ping-TTL\n"
    elif [ $ttl -ge 192 -a $ttl -le 254 ]; then
        # Posiblemente Cisco IOS
        echo -e "\n${info} ${green} Extracting information...\n"
        echo -e "\t${indicator} ${green}Host:     ${white}$ip"
        echo -e "\t${indicator} ${green}TTL:      ${white}$ttl"
        echo -e "\t${indicator} ${green}OS:       ${yellow}Possibly Cisco IOS"
        echo -e "\n${white}TTL de 192 a 254: Puede estar asociado con dispositivos de red como routers y switches Cisco IOS."
        echo -e "\n${info} ${white}GITHUB OFICIAL: ${green}https://github.com/JennValentine/Ping-TTL\n"
    else
        # Sistema desconocido
        echo -e "\n${info} ${green} Extracting information...\n"
        echo -e "\t${indicator} Unknown System\n"
        echo -e "\n${info} ${green}Information not available"
        echo -e "\n${info} ${white}GITHUB OFICIAL: ${green}https://github.com/JennValentine/Ping-TTL\n"
    fi
    exit 0
}

# Comprobar si se proporcionó un único argumento
if [ $# -eq 1 ]; then
    # Verificar si el comando ping tuvo éxito y el valor de TTL es válido
    if [ $? -eq 0 -a $ttl -le 512 -a $ttl -ge 1 ] 2>/dev/null; then
        # Llamar a la función tipe_ttl() para determinar el sistema operativo
        tipe_ttl $1 $ttl
    fi
    # Mostrar mensaje de error si no se proporcionó un único argumento o el ping falló
    echo -e "\n${error} ERROR, coloque un parametro valido"
    echo -e "     o verifique si el host esta activo!"
    echo -e "\n${info} ${white}GITHUB OFICIAL: ${green}https://github.com/JennValentine/Ping-TTL\n"
    exit 1
else
    # Mostrar el modo de uso si no se proporcionó un único argumento
    echo -e "\n${info} ${green} EL modo de uso es:\n"
    echo -e "\t${white} Ejemplo con IP         ${green}$0 8.8.8.8    | ${green}pttl 8.8.8.8"
    echo -e "\t${white} Ejemplo con dominio    ${green}$0 google.com | ${green}pttl google.com"
    echo -e "\n${info} ${white}GITHUB OFICIAL: ${green}https://github.com/JennValentine/Ping-TTL\n"
fi

# Fin del script
