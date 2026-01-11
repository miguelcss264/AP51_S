BD="bdlibros.txt"

generos=("Narrativa" "Poesía" "Ensayo" "Ciencia ficción" "Fantasía" "No ficción" "Biografía" "Historia" "Misterio" "Romance")

while true; do
  read -rp "Título: " titulo
  [ -n "$titulo" ] && break
  echo "El título no puede estar vacío."
done

while true; do
  read -rp "Año (ej. 2020): " anio
  if [[ "$anio" =~ ^[0-9]{1,4}$ ]]; then
    break
  else
    echo "Introduce un año numérico (1 a 4 dígitos)."
  fi
done

while true; do
  read -rp "Editorial: " editorial
  [ -n "$editorial" ] && break
  echo "La editorial no puede estar vacía."
done

echo "Selecciona un género:"
select genero in "${generos[@]}"; do
  if [ -n "$genero" ]; then
    break
  else
    echo "Opción inválida. Intenta de nuevo."
  fi
done

printf "%s|%s|%s|%s\n" "$titulo" "$anio" "$editorial" "$genero" >> "$BD"

echo "Libro añadido a $BD:"
printf "  Título: %s\n  Año: %s\n  Editorial: %s\n  Género: %s\n" "$titulo" "$anio" "$editorial" "$genero"