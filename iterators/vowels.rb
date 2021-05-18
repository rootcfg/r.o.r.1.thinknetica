vowels = {}
('a'..'z').each_with_index do |val,index|
  vowels[val] = index if val.match(/[aeiou]/)
end

puts vowels