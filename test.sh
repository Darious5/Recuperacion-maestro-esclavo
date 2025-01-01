#!/bin/bash -x
#
# USAGE: ./test.sh <nameserver-ip>
#

# Salir si algún comando falla
set -euo pipefail

# Comprobar si se ha pasado un argumento
if [ -z "${1:-}" ]; then
    echo "Error: Se debe proporcionar la dirección IP del servidor DNS."
    exit 1
fi

function resolver () {
    # Ejecutar dig y comprobar si fue exitoso
    dig "$@" @$nameserver +short
    if [ $? -ne 0 ]; then
        echo "Error: La resolución de '$1' falló."
    else
        echo "Éxito: Resolución de '$1' exitosa."
    fi
}

nameserver="$1"

resolver mercurio.sistema.test
resolver venus.sistema.test
resolver tierra.sistema.test
resolver marte.sistema.test

resolver ns1.sistema.test
resolver ns2.sistema.test

resolver sistema.test mx
resolver sistema.test ns

resolver -x 192.168.57.101
resolver -x 192.168.57.102
resolver -x 192.168.57.103
resolver -x 192.168.57.104

