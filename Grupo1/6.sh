BD="bdlibros.txt"

pausa() { read -rp "Pulsa Enter para continuar..."; }

asegura_bd() {
  if [ ! -f "$BD" ]; then
    echo "No se encontró $BD. Créalo primero (usa la opción 5 para insertar)."
    return 1
  fi
  return 0
}

buscar() {
  local campo label patron
  campo="$1"   
  label="$2"
  patron="$3"

  if ! asegura_bd; then return; fi

  local resultados
  resultados=$(grep -i "^[^|]*" "$BD" | awk -F"|" -v idx="$campo" -v pat="$patron" 'BEGIN{IGNORECASE=1}
    $idx ~ pat {
      printf "Título: %s | Año: %s | Editorial: %s | Género: %s\n", $1, $2, $3, $4
    }')

  if [ -n "$resultados" ]; then
    echo "Resultados por $label que coinciden con \"$patron\":"
    echo "$resultados"
  else
    echo "No se encontraron libros para \"$patron\" en $label."
  fi
}

insertar() {
  read -rp "Título: " titulo
  while [ -z "$titulo" ]; do
    echo "El título no puede estar vacío."
    read -rp "Título: " titulo
  done

  while true; do
    read -rp "Año (1-4 dígitos): " anio
    [[ "$anio" =~ ^[0-9]{1,4}$ ]] && break
    echo "Introduce un año numérico (1-4 dígitos)."
  done

  read -rp "Editorial: " editorial
  while [ -z "$editorial" ]; do
    echo "La editorial no puede estar vacía."
    read -rp "Editorial: " editorial
  done

  generos=("Narrativa" "Poesía" "Ensayo" "Ciencia ficción" "Fantasía" "No ficción" "Biografía" "Historia" "Misterio" "Romance")
  echo "Selecciona un género:"
  select genero in "${generos[@]}"; do
    [ -n "$genero" ] && break
    echo "Opción inválida. Intenta de nuevo."
  done

  printf "%s|%s|%s|%s\n" "$titulo" "$anio" "$editorial" "$genero" >> "$BD"
  echo "Libro añadido a $BD."
}
-
while true; do
  clear 2>/dev/null
  cat <<'MENU'
==== Menú de libros ====
1) Buscar por título
2) Buscar por año
3) Buscar por editorial
4) Buscar por género
5) Insertar libro
6) Salir
MENU
  read -rp "Elige opción (1-6): " op

  case "$op" in
    1)
      read -rp "Introduce texto a buscar en TÍTULO: " q
      buscar 1 "título" "$q"
      pausa
      ;;
    2)
      read -rp "Introduce AÑO exacto o patrón (ej. 202, 2020): " q
      buscar 2 "año" "$q"
      pausa
      ;;
    3)
      read -rp "Introduce texto a buscar en EDITORIAL: " q
      buscar 3 "editorial" "$q"
      pausa
      ;;
    4)
      read -rp "Introduce texto a buscar en GÉNERO: " q
      buscar 4 "género" "$q"
      pausa
      ;;
    5)
      insertar
      pausa
      ;;
    6)
      echo "Saliendo..."
      exit 0
      ;;
    *)
      echo "Opción inválida."
      pausa
      ;;
  esac
done