# frozen_string_literal: true

# Solution to Advent of Code 2018 Day 2 Part 2
# https://adventofcode.com/2018/day/2#part2
# Answer is: tiwcdpbseqhxryfmgkvjujvza

# input = %w[abcde fghij klmno pqrst fguij axcye wvxyz]
input = %w[oiwcdpbseqgxryfmlpktnupvza oiwddpbsuqhxryfmlgkznujvza ziwcdpbsechxrvfmlgktnujvza oiwcgpbseqhxryfmmgktnhjvza
           owwcdpbseqhxryfmlgktnqjvze oiscdkbseqhxrffmlgktnujvza oiwcdibseqoxrnfmlgktnujvza oiwcdpbsejhxryfmlektnujiza
           oewcdpbsephxryfmlgkwnujvza riwcdpbseqhxryfmlgktnujzaa omwcdpbseqwxryfmlgktnujvqa oiwcdqqneqhxryfmlgktnujvza
           oawcdvaseqhxryfmlgktnujvza oiwcdabseqhxcyfmlkktnujvza oiwcdpbseqhxryfmlrktrufvza oiwcdpbseqhxdyfmlgqtnujkza
           oiwcdpbseqhxrmfolgktnujvzy oiwcdpeseqhxnyfmlgktnejvza oiwcdpbseqhxrynmlaktlujvza oiwcdpbseqixryfmlektncjvza
           liwtdpbseqhxryfylgktnujvza ouwcdpbszqhxryfmlgktnajvza oiwzdpbseqhxryfmngktnujvga wiwcfpbseqhxryfmlgktnuhvza
           oiwcdpbselhfryfmlrktnujvza oywcdpbveqhxryfmlgktnujdza oiwcdpbsiqhxryfmqiktnujvza obwcdhbseqhxryfmlgktnujvqa
           oitcdpbseqhfryfmlyktnujvza oiwcdpbseqhxryfmlnutnujqza oiwcdpbseqhxnyfmlhktnujtza oiwcdpbseqhbryfmlgkunuwvza
           oiwcopbseqhiryfmlgktnkjvza oiwcdpsseqhxryfklrktnujvza oiwcdpsrsqhxryfmlgktnujvza oiwcdpbsyqrxryfmlgktnujvzc
           ojwcepbseqhxryfmlgktnujvfa oiwcdpbseqhxrlfmlgvtnujvzr oiycdpbsethsryfmlgktnujvza eiwcdpbseqwxryfmlgktnujcza
           oiocdpbseqhxryfxlgktaujvza qiwydpbseqhpryfmlgktnujvza ziwcdpbseqhxryfmlgktsuuvza oiwcdpbseqheryfmygxtnujvza
           oiwidpbseqhxryfulgktnujvzm oiscdpdseqhxryfmlgktnujvya oiwmypbseqhxryfmlgktnuxvza oizcwbbseqhxryfmlgktnujvza
           oiwcdpbseqpxryfmlgxfnujvza oiwpdpbscqhxryxmlgktnujvza oiwcdpbseqhxrifrlgkxnujvza oiwcdpbsrqhxrifmlgktnzjvza
           tiwcdpbseqhxryfmegkvjujvza oiwcddbseqhxryfingktnujvza oiwcdpbsiqhiryfmlgktnucvza oiwcipbseqhxrkfmlgktnuvvza
           kiwcdpbseqhxryfmlbkonujvza qiwcdhbsedhxryfmlgktnujvza siwcdpbseqhxryfmsgktnujvua oqwcdpbseqhxryfmlyktndjvza
           oiwcqnbseehxryfmlgktnujvza oiwcdybseqhxryfmlgbtnujvia oiwcdpbsejhxryfdlgktngjvza oawcdpbseqhxrbfmlkktnujvza
           oilcdpbseqhhrjfmlgktnujvza oibcdpbseqhxryfmngktnucvza niwcdpbseqhxryfmlgkuaujvza oiwcdpbseqhxryfmqgmtnujvha
           oiwcdpbseqhcryfxlgktnzjvza oiwcdpaseqhxryfmqgktnujvzl oiwcdpbseqhxjyfmlgkonujvzx oiwmdzbseqlxryfmlgktnujvza
           oiwhdpbsexhxryfmlgktnujvzw oiwctpbseqhxryfmlgktnummza oiwcdpbseqoxrydmlgktnujvoa oiwkdpvseqhxeyfmlgktnujvza
           oixcdpbsemhxryfmlgctnujvza oimcdpbseqhxryfmlgktnujvlr oiwcdpbseehxrywmlgktnejvza oiwcdpbseqoxhyfmlgktnujyza
           oiwcdpbsethxryfmlgktnrjvxa oiwcdpbxeqhxryfmlgktnrjvzb ogeadpbseqhxryfmlgktnujvza eiwcdpbseqhxryfmlgktnvuvza
           oiwcdpbseqhxryfmlgktnujaxv siwcdpbsuqhxryfmlgktnuavza oixcdpbseqhxryfmlgatnujvzy oiwcdpbzeghmryfmlgktnujvza
           oiwcdpbieqhxryfmlgktyujvzr oiwcdpbseqhxeyfhlgktngjvza oiwcdpbseqhjoyrmlgktnujvza iiwcdpbseqhxryfmwhktnujvza
           oixcdpbsiqhxryfmagktnujvza oiwcdpfljqhxryfmlgktnujvza oivcdpbseqhxrqfmlgktnujvca ovwcdpbseqhxzyfmlgkenujvza
           oiwxdpgseqhxryfmlgktnhjvza oibcdpbbeohxryfmlgktnujvza oiwcrpbseqhxrygmlgwtnujvza jiwcdpbseqkxryfmlgntnujvza
           oiwcdbbseqhxrywmlgktnujvra oiwcdpbteqyxoyfmlgktnujvza oiwcdjbsvqvxryfmlgktnujvza obwcdukseqhxryfmlgktnujvza
           oifcdpdseqhxryfmlgktnujsza oiwcdpbseqhxryfalgktnujyda oiwcwpbseqhxrnfmkgktnujvza oswcdpbsethcryfmlgktnujvza
           oiwcdpbieqhxryfmlgktnuoiza oiwcdibsehhxryfmzgktnujvza oisjdpbseqhxryfmfgktnujvza oiwcjpbseqkxqyfmlgktnujvza
           obwcdpbshqhgryfmlgktnujvza oiwcspbseqhxryxmlgktnujvzl oiwcdvbswqhxryfmlgklnujvza oiwcdhuseqhxryfmlgdtnujvza
           oiwcdpbkeqdxryfmlgktnujvzv oiwcdpzseqhxcyfmlgksnujvza oiwcdpbseqhxryfmbkkvnujvza qiwcdpbseqhxrnfmlgktnujvha
           okwcdpbseqhxryfmdgktgujvza oiwcdpbkeqhxryfmldktnujvzu oiwctpxseqhxgyfmlgktnujvza oiwcdpbseqhxrykmlgktnujita
           oiwcdpbseqhxryfmldktyujnza oiwcdpbszqhxrjfmlgktnuqvza oiwcdpbeeqhxrykmlgktnujrza oiwcvpbseqhxryhmlgwtnujvza
           oiwcdpbpeehxryfmlgktnujvzz oiwcdbbsxqhxyyfmlgktnujvza oiwkdpbseqhxryfplgktnujeza opwcdpbseqhxdyfmlgctnujvza
           oowcdpbseqhnryfmlgktnujvga oawzdibseqhxryfmlgktnujvza oiwcdpbfeqzxrjfmlgktnujvza oiwcdpbseqaxryfmlgkonulvza
           oiacdpbseqvxryfmlgktvujvza oiwudpbseqhxryfwlgktnujvka oiwcdpbjeqhxryfymgktnujvza oiwcdpbweqhxrynmlgktnujaza
           oiwcdpbseqdxryfclgvtnujvza oiwcdppseqhxryfmlgmtzujvza oiwcdpbseqhxrhfelektnujvza kiwcdpbsnqhxryfmegktnujvza
           oiwcdpbseqpxryfmlgzwnujvza eiwcdpbseqnxryfplgktnujvza oiwcdbbseqhxryfmlmktnujvha oiwcdpbseqhxryfmlgktjhjvka
           oiwcdpbseqhxnyfylgktnujvzs oiwcdpbbxqhxryfmzgktnujvza opwcdpbseqhfryfmlgktnujzza oiwcdpbsjqpxryfmtgktnujvza
           oiwcdpbseqhyqbfmlgktnujvza oxwcdpbseqhxrffmlgktiujvza oiwcdpbseqhxgyfmlgytnujvzq oiwidpbseqhxryfmlgxtnujvzd
           oiwcdpbshqhxryzmlpktnujvza oifcdpbseqbxryfmlgktdujvza biwcdzbseqhxtyfmlgktnujvza oiwcdpbswqhxryfmlgutnujvca
           xiwcdpbseqhxryxmlnktnujvza oiwcdpzseqhxryfrlgktdujvza oiwudpbseqhxryfmlgkqnurvza oiwqdpbseihiryfmlgktnujvza
           iiwjdpbseqhxryamlgktnujvza oiwcdplseqhqryfmmgktnujvza oiwcdppseqhxrmfmlgklnujvza oiwcdobseqhxryfmmgkttujvza
           odwcdpbseqhxryfmlgktnujvyk oiwcdpkseqhxrhfmlgktntjvza oiocdpbseqhxryfmlgjknujvza oiicdpbieqhxryfmlgksnujvza
           oiwcdpbseqhxryemlgktnujdla oiwcdpbseqdxryfmlgktsujvzt oiwcdcksnqhxryfmlgktnujvza oowcdpbseqhxryfmlgsfnujvza
           oawcdpbseqhxryfmljktnuevza oiwcdpbsaqhxrffmzgktnujvza oiwcipbseqhcryfmlgktnujvga oiwcdpbsewhxrbfmlgktnuuvza
           oiwcdpbsewhxryfmlgkunujvzc oiwcdpbseqhxryfmlgktiujkga jiwcdpbseqhxrlfmlgktnurvza tiwcdpbseqoxryfmliktnujvza
           oiwcdpbsenhxryfmlgkskujvza oiwcdpbseqhxvyfmlhktoujvza oiwcdpbseqhxeyfmlgmtnunvza oiwcdpbseqhxdyfmloktnujvzu
           oiwcdpbseqgxryfmlgkynejvza oudcdpbseqhxryfmlgktmujvza oiwcdpbseqhxryfmvgktnucvzc oiwcdpbseqhxrysalgwtnujvza
           odwodpbseqhgryfmlgktnujvza oiwcdpbseqheryzmlgktnujgza oiwcdpbseqhxryfalgwtnujvba oiwcdpbseqhxryfmlgtdnuhvza
           oiocdpbseqhxrefulgktnujvza kiwcdpbseqhxrywolgktnujvza niwcdpbseksxryfmlgktnujvza oiwcdybseqexryfalgktnujvza
           oiwcdpbbeqhxryamlgktnujpza oiecdqbseqhxryfmlgktnujcza oiwcdpbsqqhxlyfmlpktnujvza oiwcdpbsaqheryfmlgktnujlza
           oiecdpbseqhxryfmlgkknujvzz oiwcapbsdqhxryfmlgktvujvza ojwcdxbseqhxryfmlgktrujvza oiwhdpbseqvxrzfmlgktnujvza
           oiwcdppseqhtryfmlgktnujvzs oikcdpbsfqhxryfmdgktnujvza owwczpbseqhxryfilgktnujvza oifwdpbseqhxryfmlgktnujfza
           oowcdpbseqhxrprmlgktnujvza oiwcapbseqhxryfmjgktnujvze oiwcdpaseqhdrybmlgktnujvza tiwcdpbseqhxryfmlgkvjujvza
           xiwcdpbseqhoryfmlgktnujvqa eiwrdpbsyqhxryfmlgktnujvza oiwcdpbseqhxranmlgktnujvzt oiwcdpbseqhxryfqlgktnudaza
           oiwcdpbsvqhxrywmlgktnsjvza oewcdpbseqhxryfmlgkunujvma oiwcdpbseqhjrywmlgktnujvzb omwcdpbseqhxryfmlgktwujsza
           oiwcdpbyxqhxryfmlgrtnujvza oiwidpbseqhxryfhlgktnunvza oqwcdpbweqhxrybmlgktnujvza oiwcdqbseqhxryfrlgktnujfza
           oiacdpbseqhdryfmlgktaujvza oiwcdpbstqhxmyfmlgktyujvza oiwcdpbseqhxeyfclgktjujvza wiwcdpeseqhxryfmlgktnujvzx
           viwcdpbseqhxryfmlgvtvujvza oircdpbseqhxcyfmlgktnujvma miwcdpbseqtwryfmlgktnujvza oiwcppbseqhxcyfmlgxtnujvza
           giwcrpbseqhxryfmlgktnudvza onwcvpbseqhxryfmlgktnujqza oiwcipbseqhxryfmlgitnuqvza oiwcdpbseqhxryjmlgkonufvza
           oiwnwpbseqhxtyfmlgktnujvza oiwcypbseqhxryfmlgetnujvzv oiwcdpbseqhxryqmljktnkjvza olwcdpbseqhxryfmlgkenujvba
           biwcdpbseqwxrywmlgktnujvza oiwcdpbsevhmryjmlgktnujvza oiwcdpbseqhxryfmlzktnkjvzv oiwudpbseqhxrefmlgktnujvia
           oiicdpbseqhxryfdloktnujvza oihcjpbsxqhxryfmlgktnujvza]

def comp_strings(a, b)
  i = 0
  diff = 0
  while i < a.length
    diff += 1 if a[i] != b[i]
    i += 1
  end
  diff
end

def eq_chars_in_strings(a, b)
  i = 0
  eq = ''
  while i < a.length
    eq += a[i] if a[i] == b[i]
    i += 1
  end
  eq
end

i = 0
done = false
while i < input.length
  j = 0
  while j < input.length
    if j == i
      j += 1
      next
    end

    diff = comp_strings(input[i], input[j])
    j += 1
    next if diff != 1

    puts eq_chars_in_strings(input[i], input[j - 1])
    done = true
    break
  end
  break if done

  i += 1
end
