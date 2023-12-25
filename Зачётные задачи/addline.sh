#!/bin/bash

# Функция для вывода сообщения об ошибке и завершения скрипта
die() {
  echo "$1" >&2
  exit 1
}

# Проверка наличия нужного количества аргументов
if [ "$#" -ne 1 ]; then
  die "Использование: $0 <путь_к_каталогу>"
fi

# Чтение аргумента скрипта
directory="$1"

# Проверка, что директория существует
if [ ! -d "$directory" ]; then
  die "Ошибка: '$directory' не является каталогом."
fi

# Формирование строки для добавления в файл
user_name=$(whoami)
current_date=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
line_to_add="Approved $user_name $current_date"

# Обработка регулярных файлов в каталоге
for file in "$directory"/*.txt; do
  # Проверка, что файл существует и является обычным файлом
  if [ -f "$file" ]; then
    # Добавление строки в начало файла
    echo "$line_to_add" | cat - "$file" >tempfile && mv tempfile "$file"
    echo "Добавлена строка в файл: $file"
  fi
done

echo "Готово!"
