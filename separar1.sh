#!/bin/bash




# Pedir la ruta en donde buscara los archivos 
echo "Ingrese la ruta donde están los archivos a organizar:"
read DIRECTORIO_ORIGEN

# esto crea los directorios para organizar los archivos  
crear_directorios() {

    # Creando el directorio segun la persona y la extencion que tengan con un bucle 
 
    for persona in esmeralda carlos eduardo; do
        mkdir -p "$persona/jpg"
        mkdir -p "$persona/mp3"
        mkdir -p "$persona/mp4"
    done
}

# esta es la funcion poderosa con un bucle for, if y un siwch case para poner cada  una de las estenciones 

organizar_archivos() {

    
    for archivo in *; do
        # Aqui hacemos algo para ignorar si es un directorio y no intervenga en el acomodo 
        if [ -f "$archivo" ]; then
            # se busca la extencion del archivo 
            extension="${archivo##*.}"
            extension=$(echo "$extension" | tr '[:upper:]' '[:lower:]')  # esto para todo ponerlo en minusculas 
            
            # Con el IF buscaremos  el nombre de la persona en el archivo
            if [[ "$archivo" =~ (esmeralda|carlos|eduardo) ]]; then
                persona="${BASH_REMATCH[1]}"
                persona=$(echo "$persona" | tr '[:upper:]' '[:lower:]')  # igual se convierte en minusculas
                
                # esto verificara la extensión y movera el archivo
                case "$extension" in
                    jpg|jpeg)
                        mv "$archivo" "$persona/jpg/"
                        echo "Moviendo $archivo a $persona/jpg/"
                        ;;
                    mp3)
                        mv "$archivo" "$persona/mp3/"
                        echo "Moviendo $archivo a $persona/mp3/"
                        ;;
                    mp4)
                        mv "$archivo" "$persona/mp4/"
                        echo "Moviendo $archivo a $persona/mp4/"
                        ;;
                    *)
                        echo "Extensión no reconocida para el archivo: $archivo"
                        ;;
                esac
            else
                echo "No se encontró un nombre válido en el archivo: $archivo"
            fi
        fi
    done
}

# Función principal
main() {
    # Cambiar al directorio especificado
    cd "$DIRECTORIO_ORIGEN" || exit 1
    
    echo "Creando estructura de directorios..."
    crear_directorios
    
    echo "Organizando archivos..."
    organizar_archivos
    
    echo "¡Organización completada!"
}

# Ejecutar el script
main
