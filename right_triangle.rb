puts "Введите сторону a:"
a_side = gets.chomp.to_f
puts "Введите сторону b:"
b_side = gets.chomp.to_f
puts "Введите сторону c:"
c_side = gets.chomp.to_f

cath1, cath2, hypo = a_side, b_side, c_side

if a_side == b_side && a_side == c_side
  puts 'Треугольник равнобедренный и расносторонний'
elsif hypo**2 == cath1**2 + cath2**2
  puts 'Треугольник прямоугольный'
elsif a_side == b_side && a_side == c_side && hypo**2 == cath1**2 + cath2**2
  puts 'треугольник одновременно и прямоугольный, и равнобедренный'
else
  puts 'Треугольник не прямоугольный'
end