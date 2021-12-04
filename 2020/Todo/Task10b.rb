# input = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
# input = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]
input = [66, 7, 73, 162, 62, 165, 157, 158, 137, 125, 138, 59, 36, 40, 94, 95, 13, 35, 136, 96, 156, 155, 24, 84, 42, 171, 142, 3, 104, 149, 83, 129, 19, 122, 68, 103, 74, 118, 20, 110, 54, 127, 88, 31, 135, 26, 126, 2, 51, 91, 16, 65, 128, 119, 67, 48, 111, 29, 49, 12, 132, 17, 41, 166, 75, 146, 50, 30, 1, 164, 112, 34, 18, 72, 97, 145, 11, 117, 58, 78, 152, 90, 172, 163, 89, 107, 45, 37, 79, 159, 141, 105, 10, 115, 69, 170, 25, 100, 80, 4, 85, 169, 106, 57, 116, 23]
device = input.max

start = 0
ways = 1

while start < device
    if input.include?(start + 1) && input.include?(start + 2) && input.include?(start + 3)
        ways *= 2
        start += 1
    elsif input.include?(start + 1) && input.include?(start + 2)
        ways *= 2
        start += 1
    elsif input.include?(start + 1) && input.include?(start + 3)
        ways *= 2
        start += 1
    elsif input.include?(start + 2) && input.include?(start + 3)
        ways *= 2
        start += 2
    elsif input.include?(start + 1)
        start += 1
    elsif input.include?(start + 2)
        start += 2
    elsif input.include?(start + 3)
        start += 3
    end
end

puts "#{ways}"

