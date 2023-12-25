#!/bin/bash

# Проверка количества аргументов
if [ "$#" -ne 1 ]; then
    echo "Ошибка: Пожалуйста, укажите только один аргумент - путь к каталогу."
    exit 1
fi

directory=$1

# Проверка на существование каталога
if [ ! -d "$directory" ]; then
    echo "Ошибка: Указанный путь не является каталогом."
    exit 1
fi

declare -A suffix_count  # Ассоциативный массив для подсчета суффиксов

# Функция для получения суффикса из имени файла
get_suffix() {
    filename=$(basename -- "$1")
    suffix="${filename##*.}"  # Получаем суффикс
    if [ "$suffix" = "$filename" ]; then
        suffix="no suffix"  # Если нет суффикса, присваиваем "no suffix"
    fi
    echo "$suffix"
}

# Рекурсивный обход каталога для сбора статистики
while IFS= read -r -d '' file; do
    suffix=$(get_suffix "$file")
    ((suffix_count[$suffix]++))
done < <(find "$directory" -type f -print0)

# Вывод статистики
for key in "${!suffix_count[@]}"; do
    echo "$key: ${suffix_count[$key]}"
done | sort -rn -k2
