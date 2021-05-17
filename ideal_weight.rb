puts "Представьтесь, пожалуйста!"
first_name = gets.chomp

puts "Какой Ваш рост?"
heigth = gets.chomp.to_i

ideal_weight = (heigth - 110) * 1.15

if ideal_weight < 0
  puts "Ваш вес уже оптимальный"
else
  puts "Приветствуем тебя #{ first_name } ! Твой идеальный вес равен: #{ ideal_weight }"
end