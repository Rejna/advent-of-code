def extended_gcd(a, b)
    last_remainder, remainder = a.abs, b.abs
    x, last_x = 0, 1
    while remainder != 0
        last_remainder, (quotient, remainder) = remainder, last_remainder.divmod(remainder)
        x, last_x = last_x - quotient*x, x
    end
    return last_remainder, last_x * (a < 0 ? -1 : 1)
end

def invmod(e, et)
    g, x = extended_gcd(e, et)
    if g != 1
        raise 'Multiplicative inverse modulo does not exist!'
    end
    x % et
end

def chinese_remainder(mods, remainders)
    max = mods.inject( :* )  # product of all moduli
    series = remainders.zip(mods).map{ |r,m| (r * max * invmod(max/m, m) / m) }
    series.inject( :+ ) % max
end

# input = '7,13,x,x,59,x,31,19'
input = '19,x,x,x,x,x,x,x,x,x,x,x,x,37,x,x,x,x,x,751,x,29,x,x,x,x,x,x,x,x,x,x,13,x,x,x,x,x,x,x,x,x,23,x,x,x,x,x,x,x,431,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,17'

i = 0
mods = []
remainders = []
input.split(',').each do |var|
    unless var == 'x'
        mods << var.to_i
        remainders << var.to_i - i
    end
    i += 1
end

pp mods
pp remainders
puts chinese_remainder(mods, remainders)


