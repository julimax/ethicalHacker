# colores

white="\e[97m"
red="\e[31n"
green="\e[32m"
blue="\e[34m"
bold="\e[1m"
purple="\e[35m"

# dominio a consultar

echo -e "${green}${bold}Inserte dominio: ${white}";
read domain;
echo "nombre de carpeta";
read folder;

# creamos directorios

if [ ! -d "$folder" ];then
	mkdir $folder
fi

# enumeramos los subdominios

echo -e "${red}[+]Enumerate all domains..";
assetfinder --subs-only ${domain} > $folder/assetfinder.txt 


