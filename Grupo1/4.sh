while true; do
  read -rp "Introduce el día (1-30): " dia

  if [[ "$dia" =~ ^[0-9]+$ ]] && [ "$dia" -ge 1 ] && [ "$dia" -le 30 ]; then
    resto=$(( (dia - 1) % 7 ))
    case $resto in
      0) nombre="Lunes" ;;
      1) nombre="Martes" ;;
      2) nombre="Miércoles" ;;
      3) nombre="Jueves" ;;
      4) nombre="Viernes" ;;
      5) nombre="Sábado" ;;
      6) nombre="Domingo" ;;
    esac
    echo "El día $dia es $nombre."
    break
  else
    echo "Valor inválido. Debe ser un número entre 1 y 30."
  fi
done