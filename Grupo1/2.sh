num=0
while [ "$num" -le 0 ]; do
  echo "Introduce un número mayor que 0:"
  read num
done

if [ $((num % 2)) -eq 0 ]; then
  echo "El número es par."
else
  echo "El número es impar."
fi