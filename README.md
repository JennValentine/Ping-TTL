![logo](https://github.com/JennValentine/Kali-Linux-Drivertools/blob/main/Imagenes/Kali-Linux-Drivertools.png)

# Kali linux - drivers and tools checker 
**Kali-Linux-Drivertools**

## Descripción
El script es un instalador y verificador de herramientas y controladores 
en un sistema Kali Linux, especialmente orientado a la configuración de 
herramientas y controladores relacionados con la manipulación y análisis 
de redes inalámbricas. 

## :book: Instalacion
```bash
cd /opt
sudo rm -rf Kali-Linux-Drivertools
sudo git clone https://github.com/JennValentine/Kali-Linux-Drivertools
sudo chmod +x Kali-Linux-Drivertools/*
cd Kali-Linux-Drivertools
```

## :book: Acceso directo
```bash
cd
echo "cd /opt/kalilinuxdrivertools && sudo ./kalilinuxdrivertools.sh" > kalilinuxdrivertools 
sudo chmod +x kalilinuxdrivertools
sudo rm -rf /usr/bin/kalilinuxdrivertools
sudo mv kalilinuxdrivertools /usr/local/bin/kalilinuxdrivertools
cd
```

## :book: Acceso directo (En caso de error)
```bash
sudo cp kalilinuxdrivertools.sh kalilinuxdrivertools_$RANDOM.sh
sudo mv kalilinuxdrivertools.sh kalilinuxdrivertools
sudo rm -rf /usr/bin/kalilinuxdrivertools
sudo mv kalilinuxdrivertools /usr/bin/kalilinuxdrivertools
cd
```

## Modo de Uso

Ejecuta el script con privilegios de administrador:

```bash
sudo kalilinuxdrivertools
```
DATA: Sigue las instrucciones del script para instalar o actualizar herramientas y controladores.

## :octocat: Créditos
1. [Jenn Valentine](https://t.me/JennValentine) - Developer of Kali-Linux-Drivertools 
