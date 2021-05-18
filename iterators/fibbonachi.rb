fibbonaci = [0, 1]

(2...100).each do |n|
  next_num = fibbonaci[n-1] + fibbonaci[n-2]
  fibbonaci.push(next_num)
end

puts fibbonaci.inspect