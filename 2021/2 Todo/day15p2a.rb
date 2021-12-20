# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 15 Part 1
# https://adventofcode.com/2021/day/15
# Answer is: ???

class MinHeap
  def initialize(heur)
    @list = []
    @heuristic = heur
  end

  def insert(n)
    @list << n
    @list = @list.sort_by { |a| @heuristic[a] }
  end

  def shift
    @list.shift
  end

  def first
    @list[0]
  end

  def include?(n)
    @list.include?(n)
  end

  def empty?
    @list.empty?
  end
end

def min(a, b)
  a > b ? b : a
end

def neighbours(point, input)
  i = point[0]
  j = point[1]
  neighs = []
  if i.zero?
    if j.zero?
      neighs << [i, j + 1]
    elsif j == input[i].length - 1
      neighs <<  [i, j - 1]
    else
      neighs <<  [i, j + 1]
      neighs <<  [i, j - 1]
    end
    neighs << [i + 1, j]
  elsif i == input.length - 1
    if j.zero?
      neighs <<  [i, j + 1]
    elsif j == input[i].length - 1
      neighs <<  [i, j - 1]
    else
      neighs <<  [i, j + 1]
      neighs <<  [i, j - 1]
    end
    neighs <<  [i - 1, j]
  elsif j.zero?
    neighs <<  [i + 1, j]
    neighs <<  [i, j + 1]
    neighs <<  [i - 1, j]
  elsif j == input[i].length - 1
    neighs <<  [i, j - 1]
    neighs <<  [i - 1, j]
    neighs <<  [i + 1, j]
  else
    neighs <<  [i, j + 1]
    neighs <<  [i, j - 1]
    neighs <<  [i - 1, j]
    neighs <<  [i + 1, j]
  end
  neighs
end

# input = %w[1163751742 1381373672 2136511328 3694931569 7463417111
#            1319128137 1359912421 3125421639 1293138521 2311944581]
input = %w[4474378939294561989629896994983437978985699596253525532314671357192283111874776269135656912429997578
           7219771638623996974474331969734641552892111142431138735944711231631835799842996212331146124475743238
           2961148417649542737169677941564183516932969881196199629267699818691135791971999512361149183535329621
           9871881628922851313992884355318183839744114854999945898819527955613877899148971997483443895124972749
           1919361485782789198624931971845488739823696439544194485467971198599719115839184879611199597989117999
           1762668465318987168679928273548752326493925445898712574999271872149411413954567149128321356713711996
           9758891114897878442978961731916935611295376892731655257822281645887798623165679892842795149121794562
           8794174313234999832712179769998559998319429239188767268151198118491878742622198897183212759541967655
           2988678541317271143977933951868179839261219262553692783314191948932847911897935195171794197173989921
           7937619183351979421629995717138359299237763666982678128915583393591966489388882278897968133587978187
           1771288861854197689291788182899974391348865254618377682157212997376757227474976188287284936469139151
           9183171919381592591722911886147813851975446285895928831495379146316888188317259118133391938222425326
           8999178115764971149712252879912618793998823997753599775883399792278112838295641244444695117892369594
           1873895726139973829121992299149664519785161871191838821669115381988745189919982189161288151474919995
           4984136373971951668595392799193993899717185589797683743651997948311187535129949925427154914977164128
           9999159992495621281598156294198291771196656252551198178355135412329871819929964915836591711989341781
           7448271118737319391897193945577185237289149161185958425793253988117519337798691129411823525491989579
           1912877398736652997252949361587894888177859385896119191174915547635924182517149861596823312348516838
           7411916158128158526295478182717158294634384119891189918596922443111778313519369151918184392138369342
           3989641959996582997942999622814729287794974299321769978698859937138824918999289852969229264591966121
           8248393694679143264483712911924992583617814177146997918231121311389144659299451133991759578899318192
           3927235872389919653155979999938328728187786191428826154721811577636987639937191152179849749966459891
           1948525667811945875973719911429986557611991729719152988893663912242325911951514496896839921798125311
           4987111141491841355858599711851255968675598926996649953727649597973995225881919322173123485832889187
           1365195963998349531975969939812311357919355589887113191872918217753311788481269124528221117399621391
           2618399161117299311163167989995957247641824731167387813331889776165824292119925999974397616419172118
           6291632879111763162218245818574896537571235342881933628446932929988162198918431515299983116383625972
           4989885351975368919517881131331939647361285982389886925914714583162935321262181334119131787812193875
           4299299298919624924959969574186387338111585431643179184399993147111734367892182112528965596812136913
           1913417117824121122119581991583716146219291199512144882994343791853825968313288116386929568382564187
           1111259582212962927119928188628297964251334111125433112968386513986892961393919529268118897941692493
           2715119997271968941687778579456127393214439129136886489627687923892484915195916991318729518168291959
           2291724998124331715461758417591991226316441238978117126961397713993893999191415391189914953491293518
           6651599814824738431585179992975983597917279992953923879142789688619729867911998791486584911598218845
           2918442247528921633279871699883197935812912988473973121391419422515181381798846124621198681771116747
           7172399883999223589838199921288236965432928913987668795869711289579187827728254357182673543399455211
           3569393618413195995391741993182111311863518792867229192811659349495352298888119612596629417295412514
           3998347219684977173226832679351211849496942187999476517196156923911939957433439827199611519926291969
           9977828541228662797249561538682143142912917199521133659429132814291869965747141895918621158384181577
           3967357136159726912989158186141497914658884759161819339941915817318261777142291971767934513151711191
           8778541261893461761951522343928625399856964371891169438911911122822912841986768693517712511587843892
           3833315936351459473456192583978135792776752315117136132357898139879939295549611194156997971187878978
           2999641761928943389161333525895439191749829143634997999562535389149495518993726784548236849917137469
           4214435519912859292367198497751599991519199621895696677722866184996118129977367158899387561811918658
           7231114979829829321158658131391759347796376211984948269698619841398767854635929631175398998618572335
           9313714946993197143176667115892291898319189491659939292999929988795125299947811314219729882911991887
           2431979557916685876176288971223844899949112179913119728153582922392676827594238311846859276898923985
           2298182669623428768512173915565236181839119711668131839772497512198294739345891359413973166631273169
           8252112361839197878358752854282389886943817597211988118627211731273149928198939566118122128841996531
           2337699983275712849656128989981911537185958574583845722121193117562892294498614395491592899933659212
           7835143227123429411997859131228998886319979718665139818711399818999495433364914764241123721713998422
           2342981165371313441558921141193218916711873656679413979634321347456287987891354613188158163526439664
           9968695782986491149112599371175397912721977143321762942839646919197966291866914197298621385251921577
           3998992498311799137251321139836993298621918948485199967815255118632159287218116971357568151411518924
           1888767584516918979116831969684198131139152419142419199229931716585258963961725216716375611191148939
           8679972994968135896941454213273618172633413893517415398811979928196388336225492953687951759799299494
           9268198998268358914731411728913143173989653793437178974319158741943243387571241681357965185312759759
           4514415891598969983119893138887691162819199829581939189129625117153997172489929659441995563665252756
           9761151889796191211989125275371563715891139933695658126189249913196967329183393395969219863889676661
           2938315992611197591948197275927991961719112797199755413492386942224942718236489121713581914899162893
           4395774214496174235572725299871291344821199963513129911973529221391842392121228344796144961395373279
           7169235111278731299349194879561642927221385965252469499129166943949261126118955691946896131632763991
           4182586898216472291721495499162914796616976593699934121197795791198151975744258153997558688681125324
           2771241899369961675639292111153329919298919888341935788379952838991529795168864334579341944353139918
           1929719796991998842893188199974443739822392912715991758633111534282888557598811717116422289319174234
           8227445999711199165256581394711919882435899194112272635796122499955738435681954751995754828785863335
           8729951893951458193176413529119379912287122558862639638362659118815726858589241612424874965948595588
           8511215326829698921879251514193578281912679118343826143217429129999127819784588298767727133549889612
           6382942339132989347621977329997789611123946187243171299917261115375998629792191171457419111628551833
           5196411177129652468443166759257467191294653897926186178359322737194158687342924625234616743421831915
           3119774454627842122238898938198398383523128289373178928124148914919779921881813499178793921224852955
           7531169319889954774375677294553282895191113131163599175439212797364869867596793921132718138441171912
           6731921588989796739221366138283466411951368178219585181184473112811174364385961459883733385891993199
           4574139868545716129662294787788295397897183864953171131197921294921216787929998139387985941459997892
           9114942724959127928293995753431994317864268467596979991595123389116539473212431173289917364566915973
           9341929934129358191797626852989194781281961649194523995992215232749181878422232253289971438754945431
           9711152565169547161792212418146438141573599572942189811381975633231484186771811384619293994316987371
           6131964633192235767728441171994861691529178511919117275411839951991266231998851948696438627996557551
           3148296295114114748119216197997581912166946469723628251179241221245394648451897828498337979132867349
           5619591141279131179181294531676498187714322291293127899492999728165269816922513816979398883981987125
           9291461484772577319579551995948438439426145159466288861499231447345317187441884819168882981519468534
           7168729632153199693784461154421624968914968952182817868119431781278811691271694391273878312657379273
           9946766299185992112985121571599989161421889915736923711827194941719778878516511122132169474883348691
           9856269294522977396615891811325159414911139194979131992323319999997799632878319169846119312295884989
           4478951999896991194591814281651647293997171866357947886291688317199128157536483298223818685997392164
           6118292371386186497793385499159998311132592238538673922123742571831885763912281733919347629811931136
           1559539789584621626699998299699573848437397472896218368568884152614411988211446699867863392231178582
           3955545111973721673191918166186131172392954394391219111256767119175548689756115339875111299664124644
           8532211187629552833266327798975958598213391751421237299429191278411695787897851286879811159917618734
           2929979895191915513867778943916115416353324189939545761426692999878281933282414635716916418195731288
           1752488277292284446514194696663537222777119194745592921911172268969679581894751682321198962925794788
           9137893929311663938849971741824143649379956797731399631858279684249888929391696496889397231156431327
           1867976767614781682191913943361471819244932778711517643998163299119525998895828969289556719268691861
           7964834798931319884983618211814386951383713141581986214139319531157939294721187371941194911787999195
           9136759325819523117222783968949195359947999675194157265271519931694932993191618368533937986955857334
           1253987569539135869579376395211977798915817921811334441166659757918483967813112499681797768695123417
           1194831387932819991127838412992226682976224442219982251828819129911478993471543959236282538182799247
           9183416999951935493911137611615966391419988372968197976193987713623716848299299431993223458419679991
           4962689198187192592599439628128214183938152641919458516294432194147333651495386497911639332152979188
           8798649298935671297823969873452881511219118163995469811846217496897676246893511198571281879831529181]
input = input.map { |row| row.split('').map(&:to_i) }
cave_size = input.length
start = [0, 0]
finish = [5 * cave_size - 1, 5 * cave_size - 1]

big_input = []
(cave_size * 5).times do
  big_input << Array.new(cave_size * 5, 0)
end

i = 0
while i < cave_size
  j = 0
  while j < cave_size
    big_input[i][j] = input[i][j]
    j += 1
  end
  i += 1
end

i = 0
while i < cave_size
  j = 0
  while j < cave_size
    a = 0
    while a < 5
      b = 0
      while b < 5
        if a.zero? && b.zero?
          b += 1
          next
        elsif a <= b
          big_input[a * cave_size + i][b * cave_size + j] = (big_input[a * cave_size + i][(b - 1) * cave_size + j] % 9) + 1
        else
          big_input[a * cave_size + i][b * cave_size + j] = (big_input[(a - 1) * cave_size + i][b * cave_size + j] % 9) + 1
        end
        b += 1
      end
      a += 1
    end
    j += 1
  end
  i += 1
end

# big_input.each do |row|
#   puts row.join(',')
# end

h = {}

i = 0
while i < cave_size
  j = 0
  while j < cave_size
    h[[i, j]] = if i < j
                  finish[0] - i + finish[1] - j + 1
                else
                  finish[0] - j + finish[1] - i + 1
                end
    j += 1
  end
  i += 1
end

done = false
came_from = {}
g_score = Hash.new { |_h, k| h[k] = 999_999_999_999 }
g_score[start] = 0

f_score = Hash.new { |_h, k| h[k] = 999_999_999_999 }
f_score[start] = h[start]

open_set = MinHeap.new(f_score)
open_set.insert(start)

until open_set.empty?
  current = open_set.first
  if current == finish
    done = true
    break
  end

  open_set.shift
  neighbours(current, big_input).each do |neigh|
    tentative_g_score = g_score[current] + big_input[current[0]][current[1]]
    next unless tentative_g_score < g_score[neigh]

    came_from[neigh] = current
    g_score[neigh] = tentative_g_score
    f_score[neigh] = tentative_g_score + h[neigh]
    open_set.insert(neigh) unless open_set.include?(neigh)
  end
end

puts g_score[finish]
puts f_score[finish]
puts 'FAIL' unless done

# NOT 2882
