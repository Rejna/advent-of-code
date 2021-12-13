# frozen_string_literal: true

# Solution to Advent of Code 2021 Day 13 Part 2
# https://adventofcode.com/2021/day/13#part2
# Answer is: AHPRPAUZ

def overlap_points(point1, point2)
  return '#' if point1 == '#' || point2 == '#'

  '.'
end

# input = %w[6,10 0,14 9,10 0,3 10,4 4,11 6,0 6,12 4,1 0,13 10,12 3,4 3,0 8,4 1,10 2,14 8,10 9,0]
# folds = ['fold along y=7', 'fold along x=5']

input = %w[745,436 810,236 487,101 938,527 972,747 63,284 979,179 1069,204 170,318 863,166 214,68 370,207 567,544
           930,452 1220,396 666,294 78,115 20,353 769,313 992,367 1263,228 965,466 311,851 706,280 1176,309 141,101
           972,539 830,638 726,208 388,63 43,614 1153,263 920,528 567,722 693,464 634,211 301,49 152,491 967,603
           377,873 1039,648 400,828 1176,217 425,851 730,688 940,511 1208,0 793,71 520,25 1208,3 17,60 1166,791
           480,630 867,616 194,113 574,1 1054,880 296,297 763,353 945,16 284,831 487,886 808,480 1149,303 689,547
           591,162 649,711 755,386 986,502 502,491 937,287 692,625 1208,782 1302,591 1014,821 949,32 487,738 1044,528
           1076,739 75,296 768,68 621,155 498,682 472,752 763,22 1141,682 808,801 1202,124 910,380 847,675 448,586
           641,361 738,845 959,739 502,638 555,73 686,302 457,155 70,808 433,380 487,801 549,352 473,540 1261,469
           599,723 725,241 1051,249 932,504 1211,546 1158,86 1064,395 604,280 520,229 765,768 348,254 134,25 107,353
           266,528 370,511 134,309 666,406 708,319 232,490 1247,120 561,429 185,101 666,854 1169,549 728,66 910,199
           33,9 1078,490 1190,679 676,477 113,581 157,39 919,344 1241,205 1195,816 929,891 701,103 545,768 890,43
           715,381 493,143 597,380 400,179 249,173 405,249 815,617 10,40 1141,436 731,856 1265,214 1293,834 82,843
           1143,290 552,560 348,640 77,764 837,680 624,816 1268,879 42,15 853,379 624,526 907,380 753,491 698,84
           823,456 244,173 174,544 1110,863 725,689 874,283 343,67 443,616 564,396 184,140 946,255 463,675 343,379
           743,172 967,666 134,421 102,891 1014,750 102,560 361,32 70,584 812,212 823,101 314,740 634,0 1213,653
           1203,353 221,514 960,31 821,303 1144,840 351,403 75,676 864,511 144,501 1012,47 169,682 421,653 836,513
           364,255 1158,310 634,865 937,803 462,553 1181,500 1125,59 156,458 182,142 338,600 380,697 60,446 432,423
           438,795 502,414 209,180 1158,491 937,539 333,280 52,217 720,168 664,266 602,319 403,655 85,645 82,624
           383,689 591,60 197,394 972,600 166,840 398,14 674,439 440,276 676,211 85,249 972,147 933,693 1208,508
           184,411 184,235 222,350 1197,581 249,821 766,625 147,299 574,787 112,378 713,514 1186,383 1036,697
           344,829 298,735 202,263 567,161 944,207 1181,394 1061,49 1290,0 959,179 1235,604 785,500 1029,651
           617,430 1089,94 82,185 837,802 129,394 910,715 28,16 821,591 1272,700 403,768 33,885 661,880 8,591
           1007,851 179,75 939,474 782,191 1069,297 18,455 45,8 413,697 636,295 845,631 169,884 166,54 377,693
           840,235 1110,479 892,7 758,448 1166,841 316,40 1283,572 1029,103 338,32 607,666 1083,709 370,84 815,765
           1014,597 358,592 930,890 500,861 482,861 930,157 52,289 621,9 930,442 731,655 283,26 1047,162 810,460
           636,439 1093,574 487,268 671,68 513,793 636,455 664,714 771,392 1258,547 716,29 377,201 447,166 897,242
           1141,548 348,701 386,583 457,500 316,862 954,831 45,662 1153,39 1007,155 134,869 736,787 815,325 555,508
           882,814 1020,639 659,627 912,238 1307,828 611,250 167,626 227,709 1166,53 994,539 552,0 972,152 1053,840
           1300,256 13,864 1220,483 1011,474 1071,228 996,154 458,565 298,217 390,80 619,14 758,451 92,179 674,743
           249,197 162,345 28,607 324,392 673,60 940,810 1208,675 102,894 239,228 959,403 617,464 1076,424 184,754
           800,375 1146,549 924,535 464,885 340,350 711,653 970,359 485,234 1233,130 27,124 170,682 1258,289 1044,814
           1044,227 1092,303 190,280 1273,464 77,397 1125,345 296,750 1232,616 552,891 167,886 159,617 152,819
           541,581 475,371 1268,810 555,386 433,94 1000,381 364,703 1169,101 1126,411 487,156 1302,303 509,92
           72,491 500,33 1026,383 500,460 1225,249 1126,82 152,808 1193,455 387,605 1141,458 1110,703 708,795
           1198,449 418,483 1193,439 415,666 274,157 371,474 152,577 425,884 1310,445 1058,206 1257,3 907,126
           604,154 344,65 1293,60 905,73 1138,787 807,756 462,116 45,875 1053,278 1047,322 564,498 27,26 1202,367
           621,347 211,144 63,568 152,862 684,719 172,107 701,438 557,491 441,693 144,53 502,577 800,841 351,155
           1218,246 33,459 775,728 572,192 1083,386 410,621 626,607 817,751 99,348 453,430 1021,430 137,151 1208,334
           214,618 590,726 281,91 745,458 933,245 400,199 885,851 266,667 1119,868 621,179 800,519 157,843 1103,187
           706,449 862,308 298,847 157,166 355,891 1136,190 817,378 552,334 480,544 728,439 725,653 602,249 75,710
           1233,707 1014,373 1154,458 38,700 1277,885 940,207 637,732 33,99 276,1 701,427 421,429 626,399 671,826
           330,616 58,535 1277,435 913,54 567,274 316,355 933,873 433,800 1232,115 1255,694 689,459 234,424 1143,886
           952,73 728,828 169,548 354,191 520,869 1110,31 1297,30 808,808 1197,313 661,711 823,178 38,418 42,810
           1207,448 356,735 190,614 1225,690 320,94 853,842 1029,551 1053,502 569,249 924,583 241,652 552,446 227,185
           1226,115 576,616 910,35 373,539 144,151 470,235 264,366 1292,599 974,815 711,723 356,561 1136,317 413,380
           298,719 1220,411 82,30 960,863 16,737 1158,819 308,599 408,499 266,80 972,862 856,703 1077,689 487,793
           940,84 1268,532 282,434 626,175 454,31 1240,808 408,173 500,658 889,653 457,52 837,92 214,826 1245,794
           271,648 649,880 432,471 1136,577 1141,212 276,292 77,845 1233,645 102,782 905,821 436,283 17,516 922,528
           485,794 954,677 579,655 1113,394 1235,676 686,32 1074,859 894,632 261,794 221,800 480,43 70,310 393,100
           1174,241 1282,430 50,602 1120,457 52,677 853,291 441,201 946,348 659,66 431,672 65,100 790,105 157,631
           82,621 311,155 1131,452 930,575 823,793 790,869 923,448 817,826 1044,334 738,718 1131,75 144,519 761,542
           474,513 785,739 316,712 405,645 828,861 425,43 1146,345 277,21 689,715 555,521 959,155 1258,575 638,65
           1282,464 612,810 800,53 30,592 1268,756 1243,304 830,256 848,553 403,380 1125,549 750,404 1153,843 126,191
           541,313 929,443 365,878 314,154 1268,84 358,816 185,387 159,317 536,191 331,179 26,863 1253,604 1069,373
           907,768 144,743 157,504 572,718 1077,465 1002,599 743,722 16,605 1044,831 403,318 774,703 330,392 191,26
           495,765 955,698 547,200 1235,744 1283,26 397,17 157,51 579,38 1141,234 27,572 1077,336 992,527 293,480
           410,115 970,535 1054,747 1010,54 299,420 913,726 731,598 589,346 738,624 536,703 649,14 296,149 684,287
           1165,540 701,456 694,383 13,30 1099,554 962,701 321,396 962,448 890,760 1235,150 793,184 495,129 708,249
           967,827 69,205 755,508 103,670 708,347 92,627 420,67 895,184 1195,78 885,205 293,683 639,826 1154,766
           1238,66 572,633 348,448 1073,884 681,49 544,625 1258,347 1076,515 793,408 980,392 1039,877 962,640 436,31
           67,304 878,423 823,353 1232,168 311,491 170,212 463,787 874,303 1233,389 1238,43 962,483 889,689 769,581
           996,740 621,885 897,697 922,35 1208,219 582,491 1272,879 18,159 616,252 1272,476 689,179 949,190 848,789
           380,197 1186,511 487,353 1277,99 616,511 311,403 591,326 129,603 267,448 53,667 1156,861 274,737 708,218
           1053,616 611,614 1034,1 853,52 1029,91 197,515 211,340 75,666 281,551 1004,894 923,446 835,554 351,739
           1143,626 1037,3 105,352 552,448 482,637 1277,347 1131,541 85,690 634,894 618,625]
folds = ['fold along x=655', 'fold along y=447', 'fold along x=327', 'fold along y=223', 'fold along x=163',
         'fold along y=111', 'fold along x=81', 'fold along y=55', 'fold along x=40', 'fold along y=27',
         'fold along y=13', 'fold along y=6']

input = input.map { |i| i.split(',').map(&:to_i) }
folds = folds.map { |f| f.split(' ')[2] }.map { |t| t.split('=') }.each { |a| a[1] = a[1].to_i }

size_x = input.max_by { |p| p[0] }[0] + 1
size_y = input.max_by { |p| p[1] }[1] + 1

board = []
size_y.times do
  board << Array.new(size_x, '.')
end

input.each do |i|
  board[i[1]][i[0]] = '#'
end

folds.each do |fold|
  new_board = board.clone

  i = 0
  while i < new_board.length
    j = 0
    while j < new_board[i].length
      case fold[0]
      when 'x'
        new_board[i][2 * fold[1] - j] = overlap_points(new_board[i][j], new_board[i][2 * fold[1] - j]) if j > fold[1]
      else
        new_board[2 * fold[1] - i][j] = overlap_points(new_board[i][j], new_board[2 * fold[1] - i][j]) if i > fold[1]
      end

      j += 1
    end
    i += 1
  end

  board = new_board[0..fold[1] - 1] if fold[0] == 'y'
  board = new_board.map { |row| row[0..fold[1] - 1] } if fold[0] == 'x'
end

board.each do |row|
  puts row.join
end
