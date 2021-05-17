puts "Введите коэффицент a"
a = gets.chomp.to_f
puts "Введите коэффицент b"
b = gets.chomp.to_f
puts "Введите коэффицент c"
c = gets.chomp.to_f

# Вычислим дискриминант
discr = (b ** 2) -  (4*a*c)

if discr < 0
  puts "Корней нет! Дискриминант равен #{discr.to_f}"
elsif discr > 0
  root1 =  (–b + Math.sqrt(discr)) / (2*a)
  root2 = (–b - Math.sqrt(discr)) / (2*a)
  puts "Корень1 =  #{root1}"
  puts "Корень2 =  #{root2}"
elsif   discr == 0
  puts "Корень и дискриминант равны #{ discr }"
end