if [ "$#" -ne 1 ]; then
  echo "Uso: $0 <entero_positivo>"
  exit 1
fi
if ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -le 0 ]; then
  echo "Error: el argumento debe ser un entero mayor que 0."
  exit 1
fi
limite="$1"
for ((i = 0; i <= limite; i++)); do
  echo "$i"
done