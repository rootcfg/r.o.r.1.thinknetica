my_box = {}
total = 0
price = 0

loop do
  puts "Введите название товара или stop"
  label = gets.chomp!
  break if label.downcase == 'stop'
  if my_box.include?(label)
    puts "товар уже в корзине"
    break
  end
  puts "Введите цену"
  price = gets.chomp!.to_f
  puts "Введите количество"
  count = gets.chomp!.to_f
  my_box[label] = { :price => price, :count => count}
  total += price * count
end

puts my_box
puts "Цена за текущий товар:  #{ price }, В корзине сейчас: #{ my_box }, Финальная сумма: #{ total }"

my_box.each_pair do |product, data|
  puts "Итоговая цена за #{product}: #{data[:price] * data[:count]}"
end