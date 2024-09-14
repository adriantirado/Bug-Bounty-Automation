#!/bin/bash

# Verificar si se proporcionó el nombre del archivo de dominios como argumento
if [ $# -ne 1 ]; then
    echo "Uso: $0 archivo_de_dominios"
    exit 1
fi

domains_file="$1"
output_dir="/root/scans"

# Crear el directorio de salida si no existe
mkdir -p "$output_dir"

# Nombre del archivo de salida único para todos los subdominios
output_file="$output_dir/all_subs.txt"

# Borrar el archivo de salida existente si lo hay
> "$output_file"

# Iterar sobre cada dominio en el archivo
while IFS= read -r domain || [[ -n "$domain" ]]; do
    # Ejecutar las herramientas de escaneo y agregar resultados al archivo de salida
    subfinder -d "$domain" -silent | anew "$output_file"
    assetfinder -subs-only "$domain" | anew "$output_file"
    #amass enum -passive -d "$domain" | anew "$output_file"

    echo "Escaneo completado para el dominio: $domain"
done < "$domains_file"

# Eliminar duplicados y ordenar el archivo de salida
sort -u -o "$output_file" "$output_file"

echo "Escaneo de subdominios completado. Todos los subdominios están en $output_file"
