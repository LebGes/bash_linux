#!/bin/bash

guessed=0
not_guessed=0
total_guesses=0
guessed_numbers=""
steps=0

while true; do
    number=$((RANDOM % 10))
    ((steps++))
    
    echo "Шаг $steps"
    read -p "Введите число от 0 до 9 (q для выхода): " user_input
    
    if [[ $user_input == "q" ]]; then
        echo "Игра завершена."
        break
    fi
    
    if ! [[ $user_input =~ ^[0-9]$ ]]; then
        echo "Ошибка! Введите одну цифру от 0 до 9 или q для выхода."
        continue
    fi
    
    if [[ $user_input -eq $number ]]; then
        ((guessed++))
        guessed_numbers+="\033[0;32m$user_input\033[0m "
        echo "Вы угадали число!"
    else
        ((not_guessed++))
        guessed_numbers+="\033[0;31m$user_input\033[0m "
        echo "Не угадали. Загаданное число: $number"
    fi
    
    ((total_guesses++))
    
    if ((total_guesses > 10)); then
        guessed_numbers=$(echo $guessed_numbers | awk '{print $NF; for(i=NF-1;i>=NF-9;i--) printf("%s ",$i)}')
    fi
    
    echo -e "Статистика игры:"
    echo "Доля угаданных чисел: $((guessed * 100 / total_guesses))%"
    echo "Доля не угаданных чисел: $((not_guessed * 100 / total_guesses))%"
    echo "Последние 10 чисел: $guessed_numbers"
done
