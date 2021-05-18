puts 'Введите день рождения  в формате DD'
day = gets.chomp!.to_i

puts 'Введите месц рождения  в формате MM'
month = gets.chomp!.to_i

puts 'Введите год рождения  в формате YYYY'
year = gets.chomp!.to_i

unless (1..31).include?(day)
  puts  "Ошибка: день введен не верно"
  exit
end

unless (1..12).include?(month)
  puts "Ошибка: месяц введен не верно"
  exit
end

unless (1900..2021).include?(year)
  puts  "Ошибка: год введен не верно"
  exit
end

# Посчитаем кол-во дней с начала месяца.
# Создаем массив с кол-вом дней в каждом месяце

days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

# Определим високосность

if year % 400 == 0 || year % 4 == 0 and year % 100 != 0
  puts "Год високосный"
  days[1] += 1
end

sum_days = days.take(month).sum + day
sum_days -= (days[month-1] - day)

puts "Количество дней с начала года: #{sum_days}"