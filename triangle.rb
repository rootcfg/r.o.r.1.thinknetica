puts "Введите основание треугольника"
triangle_base = gets.chomp.to_f

puts "Введите высоту"
triangle_height = gets.chomp.to_f

if triangle_base == 0 || triangle_height == 0
  puts "Нужны положительные значения"
else
  square = 0.5 * triangle_base * triangle_height
  puts "Площадь теругольника #{ square }"
end