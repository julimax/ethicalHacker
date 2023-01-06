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
subfinder -d ${domain} -o $folder/subfinder.txt
amass enum --passive -d $domain -o $folder/amass.txt

# enumeramos Crt.sh
echo -e "${red}{+}Enumerate Cert.sh..";
curl "https://crt.sh/?q=%25.$domain&output=json" | jq -r '.[].name_value' | sed 's/\*\.//g' | anew $folder/cert.txt

# combining resutls
echo "domains saved at $folder/domains.txt";
cat $folder/assetfinder.txt $folder/subfinder.txt  $folder/amass.txt $folder/cert.txt | anew $folder/domains.txt

# enumerating DNS
echo -e "${red}[+]Enumerating DNS..";
cat $folder/domains.txt | dnsx -a -resp-only -o $folder/dnsx.txt

# enumerate CIDR
#echo -e "${red}[+]Enumerating CIDR"
#mapcidir -l $folder/dnsx.txt -aggregate -o $folder/mapcidir.txt

# enumerate Naabu
#echo -e "${blue}[+]Enumerating NAABU";
#naabu -l $folder/mapcidr.txt top-ports 100 -sa | httpx -timeout 60 -threads 100 | anew $folder/naabuIP.txt


