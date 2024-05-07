#!/bin/bash
#====================================================
#   SCRIPT:                   KALI LINUX - DRIVERS AND TOOLS CHECKER
#   DESARROLLADO POR:         JENN VALENTINE 
#   FECHA DE ACTUALIZACIÃƒâ€œN:  07-05-2024 
#   CONTACTO POR TELEGRAMA:   https://t.me/JennValentine
#   GITHUB OFICIAL:           https://github.com/JennValentine/Findips
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

# Barra de separación
barra="${blue}|--------------------------------------------|${reset}"
bar="${yellow}--------------------------------------------${reset}"

# Comprobación de permisos de root
[[ "$(whoami)" != "root" ]] && {
    echo -e "\n${yellow}[${red}Error${yellow}] ${white}- ${yellow}Necesitas ejecutar esto como administrador (root)${reset}"
    echo -e "\n${green} sudo $0 ${reset}"
    exit 0
}

# Función para comprobar y, si es necesario, instalar la presencia de una herramienta
check_and_install_tool() {
    tool=$1
    if command -v $tool &> /dev/null; then
        echo -e "${checkmark} ${white}$tool .... ${green}Ok${reset}"
    else
        echo -e "\n${error} ${white}$tool ${yellow}no está instalado. Instalando automáticamente...${reset}\n"
        #--- sudo apt-get update
        sudo apt-get install -y $tool
        # Verificar si la instalación fue exitosa
        if command -v $tool &> /dev/null; then
            echo -e "\n${checkmark} ${white}$tool ${yellow}se ha instalado correctamente.${reset}"
        else
            echo -e "\n${error} ${yellow}No se pudo instalar ${white}$tool ${yellow}Por favor, instálalo manualmente.${reset}"
        fi
    fi
}

fun_repositorios () {
    # Actualizar repositorios
    echo -e "\n${info} Actualizar repositorios (update)......${reset}\n"
    echo -e "${green} Por defecto ${white}N ${green}= ${white}No Actualizar${reset}"
    read -p "$(echo -e "${green} Desea actualizar repositorios ahora? [N/y]:${white}") " response
    if [[ "$response" = @(y|Y) ]]; then
        # Proceso de instalación
        echo -e "${reset}"
        sudo apt-get -y update
    else
        sleep 1s
    fi
}

fun_paquetes () {
    # Actualizar paquetes instalados
    echo -e "\n${info} Actualizar paquetes instalados (upgrade)......${reset}\n"
    echo -e "${green} Por defecto ${white}N ${green}= ${white}No Actualizar${reset}"
    read -p "$(echo -e "${green} Desea actualizar paquetes instalados ahora? [N/y]:${white}") " response
    if [[ "$response" = @(y|Y) ]]; then
        # Proceso de instalación
        echo -e "${reset}"
        sudo apt-get -y upgrade
    else
        sleep 1s
    fi
}

fun_distribucion () {
    # Actualizar distribución
    echo -e "\n${info} Actualizar distribución (dist-update)......${reset}\n"
    echo -e "${green} Por defecto ${white}N ${green}= ${white}No Actualizar${reset}"
    read -p "$(echo -e "${green} Desea actualizar distribución ahora? [N/y]:${white}") " response
    if [[ "$response" = @(y|Y) ]]; then
        # Proceso de instalación
        echo -e "${reset}"
        sudo apt-get -y dist-update
    else
        sleep 1s
    fi
}

fun_driver () {    
    # Instalar realtek-rtl8188eus-dkms
    echo -e "\n${info} Instalar realtek-rtl8188eus-dkms......${reset}"
    # Instalar build-essential, git, dkms y headers
    echo -e "\n${process} Paquetes esenciales build-essential git dkms linux-headers......${reset}\n"
    sudo apt-get install -y build-essential git dkms linux-headers-$(uname -r)
    sudo apt install -y realtek-rtl8188eus-dkms
    #--- sudo apt install -y realtek-rtl8192eu-dkms
    #--- sudo apt install -y realtek-rtl8814au-dkms
    #--- sudo apt install -y realtek-rtl88XXa-dkms
    #--- sudo apt install -y realtek-rtl88x2bu-dkms
    # Instalar realtek-rtl8188fu-dkms
    echo -e "\n${info} Instalar realtek-rtl8188fu-dkms......${reset}"
    cd
    # Instalar git
    echo -e "\n${process} Paquetes esenciales git......${reset}\n"
    sudo apt-get install -y git
    cd /opt
    sudo rm -rf rtl8188fu
    sudo git clone https://github.com/kelebek333/rtl8188fu
    sudo chmod +x rtl8188fu/*
    sudo dkms add ./rtl8188fu
    sudo dkms build rtl8188fu/1.0
    sudo dkms install rtl8188fu/1.0
    sudo cp ./rtl8188fu/firmware/rtl8188fufw.bin /lib/firmware/rtlwifi/
    cd
}

fun_audio () {
    # Estos son pasos generales y pueden variar según la configuración 
    # específica de tu hardware. Se ejecutará una serie de pasos para intentar configurar y activar 
    # los controladores de audio de tu tarjeta de sonido. Ten en cuenta que algunos pasos pueden no 
    # ser necesarios o aplicables a tu configuración específica. Si encuentras 
    # problemas, asegúrate de investigar y consultar los foros de la comunidad de Kali Linux 
    # para obtener asistencia según tus necesidades y hardware específicos.
    echo -e "\n${info} Instalar driver de audio......${reset}\n"
    lspci | grep -i audio
    lsmod | grep snd
    sudo modprobe snd_hda_intel
    #--- alsamixer
    sudo service alsamixer restart
    sudo apt-get -y update
    #--- sudo apt-get -y upgrade
    sudo apt-get install pavucontrol
    #--- pavucontrol
    #--- sudo reboot
}

fun_install_tools () {
    # Instalar wifite
    echo -e "\n${info} Instalar wifite.....${reset}\n"
    sudo apt install -y wifite
    # Instalar hcxdumptool hcxtools
    echo -e "\n${process} Paquetes esenciales Instalar hcxdumptool hcxtools......${reset}\n"
    sudo apt install -y hcxdumptool hcxtools
    # Instalar dependencias para compilar Pyrit 
    echo -e "\n${process} Paquetes esenciales libpcap-dev git python2.7-dev libssl-dev zlib1g-dev libpcap-dev......${reset}\n"
    sudo apt-get install -y libpcap-dev git python2.7-dev libssl-dev zlib1g-dev libpcap-dev
    # Instalar git pyrit
    echo -e "\n${process} Paquetes esenciales git pyrit......${reset}\n"
    cd
    sudo apt-get install -y git
    cd /opt
    sudo rm -rf Pyrit
    sudo git clone https://github.com/JPaulMora/Pyrit.git
    sudo chmod +x Pyrit/*
    cd Pyrit 
    sudo python2.7 setup.py clean
    sudo python2.7 setup.py build
    sudo python2.7 setup.py install
    cd

    # Instalar airgeddon
    echo -e "\n${info} Instalar airgeddon.....${reset}\n"
    sudo apt install -y airgeddon

    # Lista de herramientas esenciales a comprobar
    essential_tools=("iw" "awk" "airmon-ng" "airodump-ng" "aircrack-ng" "xterm" "ip" "lspci" "ps")

    # Lista de herramientas opcionales a comprobar
    optional_tools=("bettercap" "ettercap" "dnsmasq" "hostapd-wpe" "beef-xss" "aireplay-ng" "bully" "nft" "pixiewps" "dhcpd" "asleap" "packetforge-ng" "hashcat" "wpaclean" "hostapd" "tcpdump" "etterlog" "tshark" "mdk4" "wash" "hcxdumptool" "reaver" "hcxpcapngtool" "john" "crunch" "lighttpd" "openssl")

    # Comprobar herramientas esenciales
    echo -e "\n${info} Herramientas esenciales: ${magenta}comprobando...${reset}\n"
    for tool in "${essential_tools[@]}"
    do
        check_and_install_tool $tool
    done

    # Comprobar y, si es necesario, instalar herramientas opcionales
    echo -e "\n${info} Herramientas opcionales: ${magenta}comprobando...${reset}\n"
    for tool in "${optional_tools[@]}"
    do
        check_and_install_tool $tool
    done

    # Instalar fluxion
    echo -e "\n${info} Instalar fluxion.....${reset}"
    cd
    # Instalar git
    echo -e "\n${process} Paquetes esenciales git......${reset}\n"
    sudo apt-get install -y git
    cd /opt
    sudo rm -rf fluxion
    sudo git clone https://www.github.com/FluxionNetwork/fluxion.git
    sudo chmod +x fluxion/*
    cd fluxion
    sudo chmod +x fluxion.sh
    cd
    echo "cd /opt/fluxion && sudo ./fluxion.sh" > fluxion 
    sudo chmod +x fluxion
    sudo mv fluxion /usr/local/bin/fluxion
    cd

    # Lista de herramientas esenciales a comprobar
    essential_tools=("aircrack-ng" "bc" "awk" "curl" "cowpatty" "dhcpd" "7zr" "hostapd" "lighttpd" "iwconfig" "macchanger" "mdk4" "dsniff" "mdk3" "nmap" "openssl" "php-cgi" "xterm" "rfkill" "unzip" "route" "fuser" "killall")

    # Comprobar herramientas esenciales
    echo -e "\n${info} Herramientas esenciales: ${magenta}comprobando...${reset}\n"
    for tool in "${essential_tools[@]}"
    do
        check_and_install_tool $tool
    done

    # Instalar sparrow-wifi
    echo -e "\n${info} Instalar sparrow-wifi......${reset}\n"
    sudo apt install -y sparrow-wifi

    # Instalar feedingbottle
    echo -e "\n${info} Instalar feedingbottle......${reset}"
    cd
    # Instalar git fluid
    echo -e "\n${process} Paquetes esenciales git fluid......${reset}\n"
    sudo apt-get install -y git
    sudo apt-get install -y fluid
    cd /opt
    sudo rm -rf feedingbottle
    sudo git clone https://github.com/ChunshengZhao/feedingbottle.git
    sudo chmod +x feedingbottle/*
    cd feedingbottle 
    #--- sudo apt-get install -y fluid
    sudo fluid -c feedingbottle.fl
    sudo fltk-config --compile feedingbottle.cxx
    sudo chmod +x feedingbottle
    sudo wget https://github.com/JennValentine/Kali-linux_drivers_and_tools_checker/raw/main/feedingbottle/feedingbottle
    #--- sudo ./feedingbottle
    cd
    echo "cd /opt/feedingbottle && sudo ./feedingbottle" > feedingbottle 
    sudo chmod +x feedingbottle
    sudo mv feedingbottle /usr/local/bin/feedingbottle
    cd

    # Lista de herramientas extras a comprobar
    # extras_tools=("wifite" "kismet" "fern-wifi-cracker" "wireshark" "eaphammer" "wifi-honey" "routersploit")

    # Comprobar y, si es necesario, instalar herramientas extras
    # echo -e "\n${info} Herramientas opcionales: ${magenta}comprobando...${reset}\n"
    # for tool in "${extras_tools[@]}"
    # do
    #     check_and_install_tool $tool
    # done
}

fun_data_system () {
    # Mostrar la configuración de red usando ifconfig
    echo -e "\n${info} ifconfig......${reset}\n"
    ifconfig

    # Mostrar información sobre interfaces inalámbricas utilizando iwconfig
    echo -e "\n${info} iwconfig......${reset}\n"
    iwconfig

    # Mostrar la lista de dispositivos USB conectados usando lsusb
    echo -e "\n${info} lsusb......${reset}\n"
    lsusb

    # Mostrar información detallada sobre las capacidades inalámbricas del sistema usando iw list
    echo -e "\n${info} iw list......${reset}\n"
    iw list
}

fun_banner () {
    echo -e "\n${green}|--------------------------------------------|"
    echo -e "|-- Kali linux - drivers and tools checker --|"
    echo -e "|----------------- ${red}WifiKali${green} -----------------|"
    echo -e "|--------------------------------------------|\n${reset}"
}

# Mostrar segundo banner
fun_banner2 () {
printf "${red}           .-  _           _  -. \n"
printf "          /   /             \   \ \n"
printf "         (   (  (\` (-o-) \`)  )   ) \n"
printf "          \   \_ \`  -+-  \` _/   / \n"
printf "           \`-       -+-       -\` \n"
printf "                    -+- ${reset}${green}Coded by: Jenn Valentine\e[0m\n"
printf "\n"
}

# Limpiar la pantalla y mostrar banner
clear
fun_banner
fun_banner2 

# Mostrar información del usuario y versión del script
echo -e "${red}   ID        ${green}:  ${white}$USER${reset}"                    
echo -e "${green}   Version   :  v0.0.01-dev"
echo -e "${green}   Update    :  [2024/05/07]${reset}\n"

# Mostrar información sobre drivers y herramientas
echo -e "${info} ${blue}Driver rtl8188fu    ${info} ${blue}Forces Audio     ${info} ${blue}Tool Wifite${reset}"
echo -e "${info} ${blue}Driver rtl8188eus                         ${info} ${blue}Tool Airgeddon${reset}"
echo -e "                                               ${info} ${blue}Tool Fluxion${reset}"
echo -e "                                               ${info} ${blue}Tool Sparrow-wifi${reset}"
echo -e "                                               ${info} ${blue}Tool Feedingbottle${reset}\n"

# Solicitar confirmación para la instalación
echo -e "${green} Por defecto ${white}N ${green}= ${white}No instalar${reset}"
read -p "$(echo -e "${green} Desea instalar los drivers y herramientas? [N/y]:${white}") " response
if [[ "$response" = @(y|Y) ]]; then

    # Proceso de instalación
    cd
    fun_repositorios
    fun_paquetes
    fun_driver
    fun_audio
    fun_install_tools
    fun_data_system

    echo -e "\n${info} ${green}Instalacion completada${reset}"
    #--- echo -e "${green}     Para terminar solo reinicie su sistema con el comando ${red}sudo reboot ${green}, ${red}shutdown -r now ${green}o manualmente${reset}"
    echo -e "${green}     Para terminar solo reinicie su sistema con el comando ${reset}"
    echo -e "\n     ${red}sudo reboot ${green}o ${red}shutdown -r now, ${green}tambien puede hacer ${red}reinicio (restart) manualmente${reset}\n"
    
    # Solicitar reiniciar su sistema
    echo -e "${green} Por defecto ${white}N ${green}= ${white}No reiniciar${reset}"
    read -p "$(echo -e "${green} Desea reiniciar su sistema ahora? [N/y]:${white}") " response
    if [[ "$response" = @(y|Y) ]]; then
        
        # Proceso de instalación
        cd
        echo -e "\n${info} Reiniciando su sistema...${reset}\n"
        sleep 3
        sudo reboot
        #--- shutdown -r now

    else
        echo -e "\n${info} Finalizando, recuerde reiniciar el sistema para aplicar los cambios...${reset}\n"
        sleep 1
        #clear
        exit
    fi
else
    echo -e "\n${red}Saliendo...${reset}\n"
    sleep 1
    #clear
    exit
fi

# Fin del script
