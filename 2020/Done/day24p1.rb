# frozen_string_literal: true

# Solution to Advent of Code 2020 Day 24 Part 1
# https://adventofcode.com/2020/day/24
# Answer is: 485

def move(i, j, dir)
  case dir
  when 'w'
    [i, j - 2]
  when 'e'
    [i, j + 2]
  when 'nw'
    [i - 1, j - 1]
  when 'ne'
    [i - 1, j + 1]
  when 'sw'
    [i + 1, j - 1]
  when 'se'
    [i + 1, j + 1]
  end
end

# input = %w[sesenwnenenewseeswwswswwnenewsewsw neeenesenwnwwswnenewnwwsewnenwseswesw seswneswswsenwwnwse
#            nwnwneseeswswnenewneswwnewseswneseene swweswneswnenwsewnwneneseenw eesenwseswswnenwswnwnwsewwnwsene
#            sewnenenenesenwsewnenwwwse wenwwweseeeweswwwnwwe wsweesenenewnwwnwsenewsenwwsesesenwne
#            neeswseenwwswnwswswnw nenwswwsewswnenenewsenwsenwnesesenew enewnwewneswsewnwswenweswnenwsenwsw
#            sweneswneswneneenwnewenewwneswswnese swwesenesewenwneswnwwneseswwne enesenwswwswneneswsenwnewswseenwsese
#            wnwnesenesenenwwnenwsewesewsesesew nenewswnwewswnenesenwnesewesw eneswnwswnwsenenwnwnwwseeswneewsenese
#            neswnwewnwnwseenwseesewsenwsweewe wseweeenwnesenwwwswnew]

# input = %w[nenwwwnwsenwneswnwnwnwnwnw senwwneeneeneneneenenesweneswenenene newnwnwnwnwnwnwesenwenenwenwnwnwwnwsw
#            wswnesewwwnwwnewswswnesw wnwwwwswwwwswwswswwswnesweww esenwneswseeseseseneseeweseseseseswse
#            neseesweenweeeewwswee senwnesewnwwsenenwsewwewswwnwwswew nwesesewswnwnwsenw nwnenewnwnwwsenwnwswnwwnww
#            eeseeeeweneeeseneweneeeeeee nwweeeeeeeswnwneneneeesenenese wewwwwwwwwswnwnewswwwwseww
#            sweneenwswswneewswnwnwneeneneswnew swsenewwsenesewseneswsenwseneswsesenee nenwnenwneswsenenenenenewnwne
#            wwwwwwwwwew nenenenwnesenwnenesewswnenenenwne seeswnwsewwnweswneswswseseseseseswsw
#            swswwenwnweswwseneneewsenwwwe eeneneenewneeewneeseneneeeneene nenweenwenenenenesenesenee
#            eswweeswsenenwnwnwwseswwnwnwneenene nwswnenwnwneenenwnwneweneswneneenwnene
#            newneneneeneneneneseenenenenewnwnewne swwwswwswwwwwwswneww swnwsenwsewnwnwneeswneeswneneswwnesene
#            neneneenenwneeswswnenenenenene wnwswnwsenwnenwnwwnwewnwwnwwnwnwnww seswnwwesenwwnwneswwnwweenwnwenw
#            wseseseseseseseseseewesenwseese seesesesesenwesesweneseweeesesesw ewnewnesenwswnesenwwsenenwenenenenew
#            eeenenenenenwneneneswneneneenee seeeseeneeeseseseseseeeswe seswseseswneswseswswswswswseswswswse
#            newwwwwswwswsenenewwwsenwswwww nenenenwnenwswenenenenenene nwnwnwnwnwnwnwsenwwwnwnwnwnwnwnwnwnesw
#            seenewnwnenesewnenesweeneeneneesw nenewswenwnwnwwnewnwseneneneswenwswsene
#            nwseesenwnenewnwswswsesenesewsesesesw sewseseeseseswseswse wswwswswsweswswswswsenwswneneseswswse
#            eeeweneseeeeeeneneeweeneee enesweenwweneneeeseeeeneenewe wwenwnenwnwswsenwnenwwwnwweswww
#            nenwenwnwnwnwnwneswnwnwswnwnwnwsenwnwnw nenwewneeneseswswesw nwswenwseswswswswsewswswswseseseneswsese
#            nwswsesesenewsweswsweseswnesew nwnwnwneneenenwnenenewnenwsenwnenenwnew nwewwwswswswwwsenwwesweswswswnew
#            sweseneswswswseswseswseswseswnwswswnwsw sweswenewneneneneneseneneeenenwnene
#            swswswswswswswswnwswswswswswswswseeswnwse swseswenwseseseseswswsesewswseswswsese enwwwwwseenwewwwnwwwnwwwww
#            wwswwwwwnwwwwwnenw eeswenwseeesenweeneeswseseeeese sweenwwneneenene enweswseeseeeeeeenweeeseee
#            wswwwswsweswswswswnewwwsw nenwswnewnenwnwnwsewnenesenenenenenenw swwneweseswswswswswwswswneswswswnesw
#            nenwnenwnwnwnenwnwsenenwnwnwnwnenwnw wnenenewneenenenwseneneneseneswwe wseenwnenwneswseneneenwneswnenwswnew
#            enwwenenenesewsweneswseswsewnenewsw eweeeeeseneeseswsesenwswsenwweee seseeeenwseeeseenwseeeeeeee
#            nwnwneneenenenenwnwnwnwnwnwneneswswnenw seeeseseseswnwseseneswnwseseswnenwsesee
#            swswswswswswswswswswswswseewswswswswne wswwwswwswnwwsew wwnwwnewwwwswsewwwwwwnwseww
#            enwnwswewneneseswnenenwswnwnwenwsenenene seseesesewneswnwsewswenwseneswwsesee
#            swseswswswsenwswswswswswseswseswnw seseseswseeseseeseswnwnewseeesesese nwnenenwnewsewnwswenenwenenene
#            ewwsesenwneneeesweeeneneeneenenew swswwneeneswswswswnwswsw neswswwwswnewwseneswnewwnwweswsew
#            nwnenewwswnwwwwwesewweswwwsesw enweewwseeneeseneseenweseneee weswneeneseneenwnwswweeeneeswwe
#            enweneeeseseeseww nenwswnenwnwnwswnwnwenwnenwnwsenenwnenene wweswseesenwsesenwe neswnwswnwneneenene
#            nwnenenewnwswenenwenwnenwnwnenenwnenw eneneewswnwwseswneswsewnenwwswnewwse
#            nwsesweeneeweseseseseseenesesesee seeseseseeeewsenwsesesenwseesesese
#            neneswnenenwneneeneneneswnwnenenwnenenene seseswwsesenesesesesesesesesesesenesesese
#            seneswesenesewneweseseneseseweeesee eeswswswseesenwsenwnweeeneeneesesw eeeseeseseesesenwseseseseeseenwnw
#            swnwswswenwswsewneswseseswwswseswnwe nwneeenenewsenene nesesenwneseswseswswwnwseswswseswseseswsw
#            sesenesewnesesesesesewseseseseesesesw wnesewsewseseswnwswswsenwswwneswnenewne eeseeeeeeseesweeeeeenwe
#            neswsewnwneswwsewneeseswsee neswseseenenwswneneenwenweneneswew eeeeswseeeeeenweeeeewene
#            nwwnwnwnwnwnwnwnwnwnenwswnwnwnw weeeesewseswsenwnwnwneswnwwnwnwne weneswswewewswseswswswswwnenwswnesw
#            nwewnwenwnwnenwnwnwswnenenwnwnwnwnwnw swswswseswneeswswswwswwswswswswswswswsw
#            sesewswenwsesewsesewnwnesesesenenwne eeeeseesweenweseeeneesweee newswsewnenwnwsewsenw
#            wswnewwwsewsewwwwswwwsewwnenw seenwnwnwesenewseeswsew nenwwwwnwnwnwwsewwnwnwwwwwsenew
#            eseeeeeeeeneeneeeeeeewseew nwneweeswnwnenenwweeweswseswene swswwwswneswswswswswseswsweswswnwswswswsw
#            nwswesenweeenwsenweewnweseswneee swswseseswswnwswswswswswswseswswnwseswe wenewnwwwewwswwweesw
#            wswswswwwswwnewswswneswseswwwswswsw nwswwesewsesewnenenwswwwwwwww eeneswnwseeeeenwweneneswnwswne
#            wwwswwwnwwewwwnwwwwweswww sesenwseseseeseswnwsesewsesesenesesese seseswnwswswswswsesweswswnwswswswseswswsw
#            enwseseswwseneseeneeseneseewseseew nwsenwnwnwnewnenwwseswnwsenwww ewneeeneweeenenweeneeeswenene
#            swswswswwswneeswesesewneswswnwnewswsw sewseswnewseneswwnw wwnwnenenwnweeneneneenwnenenesw
#            eseeneneneeswnweswesewsewneswwnene nwnwwnwnwnwnwwnwenwnwswnwnwswnwwnwe nwsenwseswwewnenwnewnwnwsenesenwnwnw
#            newswenwseweswwswswswswswneswnwsesww swwswswseswwswnwsweswnenewwswswswsw neneneeswneneewneneneeneeeneswenenw
#            eneeneneeeseweeneene swseswseseswwneseseswswsweswseseseswsw eeseeeseeeneseeeeeswseee
#            eswnwswwswsenwseswswwswseswswneeswsenwsw swwnwnwswwseswwswwswenewswswwwswsw
#            seseswseswseneseneeseswseswsesewswswsw nenenenenenwneswnwnwene wwwswneweswswwwseswswneswswswswwsw
#            wswwswneneswwswwsenwnenesewwwswse nwewwwwwnwnwnwenwsenwnwwnweswswsw seseeeeeeseseswsenwsenwewseseese
#            seenwsewseseseseeseseswseswseswsesenw nwswewwseneneseswseswnwswsenwsenwswnw
#            swswswswswswneswnweswswswswnwswswswwsesw eeseeeseseswseweeesenwseeeeese wnwwwwwwwwwwenwnw
#            eseseseseswswwneneseneeeswenesesee swneswnwnewwneeneseseneneneewnenenw weeeeeenweeeewswneeeeeese
#            eeenwsweneneesweneneeeeeeee sewwewwswnwwswswesw newswneneneneeneeswnew
#            nenenwnwwseswnenwnwnenwnenwseswneewnenw nenwnwwnwnwnwsenwnwwnwnwnwnwsenwnwnwnw
#            wwnwnwwswwwnwwnwnwneewnwnwwsenw sweswswwneneswesesenwsenwwswseswsesesese
#            wseseswseseseseseseseesenenwseseswwnwse wnwnwswwnwnwwnenwwnwwseenwwwwnwsew wenwseeseseswenwnweeeswneseesese
#            eenenwewewneneneeswe swswseswswswnwseeswnwswswsenwswswsenesenw nwwnwseewnesweeeeeseeeeeeswee
#            neneswnenenenenenenwenwwseswnenee swswswewswwwswnewsewswswsw nwnwwnwnwnwnweeswsenwnwnwnw
#            swseseswneseswseswseseseseswseswsesw swsewsenwswswseseswswswswsweseswswswnw
#            sesenwnwnwnenwnwnwnwnwnwnwnwnwnwnwnwnww swnesweswswswswswnwwwswswswswwswwsesw
#            seeeeeeseeseeesweeswnweseswnwenw neesweeeweeewneeeseneeee nwwsenenwsenenwwnwnenwwnwnwnwsenenwnenene
#            seseeseeseeseeneenwseweneswwnwse sewseseseseseesesesewseseseswseenesese wnwnesenwwwnenwwneswswwnenwwwwwsw
#            nwneenenenenenwneseneseneneneswnenwnene wnenwseewwwwwwnenwswwwswnwwnese eneewwwsewwnenwnwwnewswnwswsese
#            sweseswseeneswnenwneseesewewnwwse eeneeenewweeseseseseseeseseseeee wnwwnwnwnwwwwsewnwwenwnwnwwwnwne
#            nwnwnwnwnwnwnwnesewnwnwnwnwnwnwewnwnwnwsw nenwwneeenenwnwnenwnwwswnenenesenenwne
#            ewneeneeseweenweeeseeenweenesw enwweeseesweenwnesweweeeee seeeseseswseseswswsesewseweswsenwswsene
#            eneeweeeeeeseswseeeeswenwee swswnwseswswsenwnwnwewwswswswwnwswese esenwnwseeeswswenwnwseneenwsenwswsene
#            nwnwwnwnwnwnwnwsenwnwww swsesenwseseneswswesesesesenwseseseswsese eseswswseenwseseseseseseswwse
#            wneenwnwnwnwnwnenenwswswnenwnesenenwsw seseeseneeseeseeeswneeswsee wswwswnewswnwweneseewwwnwwwww
#            nwwwwwwnewwswwwwweeswnwwsw sewwwewwseewnewswwwnwnewnww weseseseneswesenwsesenwswseseswswsenene
#            nwewnwswnwnenwnwwwnwwweewseswnww nenenwswwnwswnwnwsenwwnenwwenwnwsew wseeeseseseeeneseseseswseenwseee
#            sesesesesesewseseeseseseseesesesenwse swseeseeeseeeeseswseweenwnwneee
#            nweswnenwswnwnwweneswswnwsenwnweswnwnenw newwsewnwnwnwnwnw wwwswwswwwswwwswwnweswwswwe
#            wswneswneseseseswsesesenwseseeswnwswsesesw nwnweneseesesweeneneeneswnewwnew
#            enwnwwnwnwnwnwnwnwnwnwnenwwnwsesenenwnw nwwnwwnwwnwnewnwnwsenwnwwesenwnwswnw neenwewewesweneweeeseswnwee
#            nwneseseseesweeeeeseweesesesee nwswenwswnwnwnwnwnwnesenenwswnenwsenwnw wwwwwswsewenwwwswnesenwwnwwnw
#            wneswnwnwwwwwnewsewwwwww swnenenewswwsenwseseswnwseseswseseeseswe wewwwnwwseewwnwwnenwnwwwww
#            swwwwwwwwwwnewwwweewww eeeneeewseweseeeeeeeewe wnwnwnwnenenenenenenwnesenwnw nenwswwnwsweneeseweneesw
#            nenenewnewneeneneeneeneneneene seseseeseseseenwseenwseseeeseeesww nenwwsenwsewsewnwnwnwnwwnwnw
#            seneeseseseseweeeeweseswse wswswswsweseseswsenwsese wnewnweenewsewswnwsenwwswswnwnwnese wwsenenwnewwwwwwswwse
#            nenwswswswsewseseenwnwsweswswswsenwe wnwseeswseenwwnenweseswswswswnesww
#            nenewneneeneseswnenesewnwnesenenenenwnwnw wenwnenesenwnenewnenenewnenesenenenwne
#            swswnwswswswseswswswswswswswswswnwseswe sesesesesesesesesesenwseeseswsewsenenese wnwwweewwwewwswwwwwwwne
#            weenwseeeeweswwneesewwwene wwswwwwwwwwwnwwwnwwnew swswseswswswnewswsewnenewswswswwwwsww
#            wewwwnesenwswenwwswwwenweswnewsw eneneseneswnwneseneswneswenenenwneswwnwne eneseeneneneeweneneneneneneene
#            swsewnwewseeneseeswseweenwne sesenwwseeswswseseseswsweswseswswswswsw neneeneneneneneneneneneswneswnwneneneene
#            seseesesenwsesesesesesesesese neneenwnenwnwnwnewnwenenwnenwseneneswnw neeweeewneeeeeeeeeseeesee
#            nwwwswswnwewnwnwwwnwewnwe wwwwwnewwswwwwse seswneneenewwnenenenenwnenesenenesewne
#            wsesenwnwswneeswswseseswsweseenwswnwsw wseseneneswnenenwwnenwnwnwnewnwnwnwsenw
#            seseseseswseseseseneswsesesesesenwsesese eeswswswnwseswsewnwswnwswnwswe wswswesewswweswswswwnwnwnesw
#            neeneeneeewnewseeneseeneneeeee seesenwnesenwseseseseneswsesesenwsesesesw
#            neswswwsenwseseseseswseseneseswnwwswnese nenesenwneneenenenewnwnenenwnwnenenenew
#            wwswswwswnwswwswwswwwswseswsw wnwsesenewsewwswswnwsweswswenewswnesw eeeseswneesweenweenw
#            senwswenesewnesenwswswweswswswseswnee wnwwwsewnwnwwswnenww neneneswswnenenenenweswneswneenenenenwne
#            seseseseseenwsesee nwnwneneswenwwwsenewnesenewseswwse neswseweewenwewwwnenwsenesesesee
#            wsewnenewewwwswswnwswwwewnwwwsw nweeeseweswseseewneeeseeenenwe wswnwenwenwwnenwswseswenwwnwnwesenwne
#            seneswswneseseseswwseseseseseseseseseswse ewnweseseseseneeesewneewsweeneese
#            seneneneneneneewnenewsenenewwsesew wwnwswwswsesweswwwwwswswswswnesw nwswnwswnwnwnwenenwnwnenwwnwnwenwnwnw
#            seeneseeeeneneeneneneweneeenwnwe nenesewnwnwnwseswsenwnwsweswwwsenenwne seseseeweeeseseeeneseneseseesesesw
#            nwneeneneneeseneeeneneenenewnesenee sesenwneswseswswswenenwswnwswswswswswsw nwwwnwnwsenwwwnwnwwnwwnwnwewnwsw
#            nenenwseneswnenesenenenenwnenenenenwnwwne swswswswwweswwwswneswswwwswswswsw
#            swswwswswwswnwswneseswswnewswwseseswswsw nwsenwswsweseseseseseseenwseswswseswsesesw
#            ewnwswswneneswneseneeswswwnwseneswne wwwwwsewwwwsewneewnwwwww sewneswseseswnweeseeeeeseeneesewse
#            seswneswswwswswseneswse nwneswnwnwnwnwnwnwnwnwenenwne wwewwwwwwwnwweseswswwwwnwsw
#            eeswseneenweeenwnweeseeeenenwsw swswwwnwwswnwwwewweswewnwnwsewsw nwwsenwnwnwwnwwwnewesesw
#            wwwnewnewwwnwwsenwsewwwwwww swsewswswseswsewseeneswseneswseswswswsw
#            nwnenwnwnwnenwsenwnwenwnwnwswswnwnwwnwnwnw sweeswnewwwnwnweseneswsewnesewswnw swneseseeswseneswnwsw
#            swweswnewswswwwswseneswnwwswnwsesesw eenwnwnenenewswswnwneenwnenwnwswnwne
#            eseseseseeseswseeseseseneseeseseenwew swsweeneswswswnwwswswswwswwnwswsweswsw
#            swsweswseswseswnwsesenewnenwswneswswswsw seswsesenweseseeeseenwseee seseeseeneeseseswsenweseewsesesesee
#            swnwnwnewnesenenwnenesenwnwnwwneneenwnw seswswsesenwswseseseneswseseweenwswsw wnwnwnwnwnwnwwwnwwnenwnwnwsw
#            nwnwswnesenwneewnwnwnwnweneseneeww seswwswneswswseswswswneseswswswswswswsw
#            newwnwsesenwnenenwnenenwwenwsenenwswnwe eenewneseesweenwneesenwwsenweese seewswwwnwwseswswwnwswenenewnew
#            seseseseseeewnenwee eeeeswwneneweneewenenweewe wsenenwswenenwesenwneswsenesenwneswnw
#            nwnenenenenenenenwneswnwnenewswnwenee newswseseenweesenweswsewwseeenenw swsenenwnwnesewwwnwwwnwwsewnewnww
#            neneneneneneneenenwnenwweneswnenewne swswseenwwsweswswswswswswewenwswwsw neeeeneneenewnewneneneseeenene
#            senwnesenwseswswsesesesenesewwswseseswne wwsenewswewnwwwwwwnwwwswswswww eswwwwnenweweswewwwswnwnwsww
#            nenwnwwnwnwsenwnenwnwsenwwnwnwnwnwnwesw eneseeneeneeseeneneeewnewneee eenenwnwneneneeswnweswseeenwneeesw
#            senwseswswswnenwnwswwseesweeseswswsw swwnewswsenwwwwwwwnwsenwnwwnewnew
#            nwnwnwnwnwnwseswnwnwnwnwnenwnenwnwnwnwnw swnwwswsenwnwwnwnwwnwenenwnwsenwnenwne
#            nenenwnenewewnenwneeeeswswneese eeneeneeneneneeesweenwneneeswee swseswswnwseswseseseswswseswswswswneswsw
#            wwewwwenwewnewwswwwswnwww wwnenwwsenwnwnwwwnwwwwwenwnwnww nwnenenenwnwneenenwnenwwsenwwnwnwnwnene
#            swswsweswwwwswwwwwwsw eeneeeneswenenweenenene eseeswnwswneeeseenwsewseeeenwnwe
#            seseseseseswsesesenesesesesewwwseesee esweeseseseseeenwsesesenweeeswe wwnewwenwnwsewswwnwnwwnwwwnww
#            nenenesenenenenenenewnwnenewenenenene nweeeseeseweeenwnwsweeeeee senwnwnwnwwswnwenwnwwnwnwnwenwneswnw
#            nwnwswnenenwnwsewsenwswsewsewnwnenenwnene wneewwwsenwewnwnwesewewnwwwsw
#            swswneswswswwenwwseswseswnwswswseswswse swwswswswswswneswseswswswwswswneswsww
#            wwseswswswswneswswswswswswswswswnwsww newwwsenewswswswwsw neneenenweneneneeneneenwneneswseswne
#            eeesesesesesewseseenew weweneswsweeenenwewneeswseenene swnewneneseeeeweneeenwnenwweswsw
#            seswsenwseesesenwseswsesesese eeweeseeeeeeneeee nwnwnesenenenenewnenwnwnwwene
#            neseswswseeswseswswswseseneswnwseswsesw nwnwenwnwwwwnweweewwsewswswwnwe nesesenwewenwseseeseswseswseneeese
#            ewnwwsenewenwwweewwnwwnwwnw nesewnwnwnwswwwswnwwnwsenwnwwnwnenewnw sewsesesewswseseneesesesesese
#            newnwnwsesenenenwsenenwwwnwsenwnesenwnwse esesenwesesenweseseseseseswswseesesese
#            sewwwswswneswwnewwsweewwwwnwsww swsewwwswwwswnwwnwwwwwewwww nenwswneneneneenwneewnesesenenenenenee
#            nwnwnwnwneswsenwnwnwnwnwnwnwwnwenwnwnwnwnw eeeeesweeeeewseeeneneeswe nwnwnwnesesewnwnwnwwnwsenwwnwwnwnwnwne
#            nenwneeneneewneeneeneneneswneeee seneswneneeswswswseseswseseseenwwswsesw
#            swnesweswseswsenwsenwewswsenwnesenwse seseseeswsesesesewsesesenesesesenwsenesese
#            wnwnenwnwwnwwwwnwseewwnwwewsew nwnwwnwnwnwwnwenwnwwnwnwnwnwnww sewsenwnenwnewnwnwnenwnwnwnwwnenwnwenw
#            nwewwnesewwwwwsenwwwnwnwwwwsww swnwswswwswswsesewswswwwewnwswswsw swseneseseseswseswseswwswseswsesw
#            swwnwwswnwnenwnwnwewsewewwnwwnw nwnwwnwnwwwwnwsesewnwnwnwnw wwnwwwenwnwseswwenwnwnwnwenwnwnwnw
#            nwnwnenwnwwnwnwneesenwwnenenenwseswne swneenwswwsenwseswswswsenweseswneswseswse
#            swsweswsewsweneswswswsenwseswsese eseeswnweeeseeeseswneesesesesesee nweswwewswnwewnwwnewsenwswwwwnw
#            nwnenenwswneeeswewseneswneswseeenw wnwwswwnwnwswenenwwenwwnwnw eeeeneeeswnweeswenweeneeene
#            swseeeweswnwneewwswnwswswesenwswnw seseswsesweseswsewswesesenwseseswsesw wnwwwnwnwwsenwnwnwnwnwnwwwwnenw
#            wswnwwwwswwewswseswwwwneneseswww neseeeneenenwnweswene wwwwwwwwnewwwwswnwesewwe swnesewenesesewneweswnwswenw
#            wsweeenwseswenwsenenweenwsee neneenwnwnwsenesenenenenenwnewsenwseswnesw
#            wnwnwnwswnenenenwneneneneneenwsenenenenw swswswswswseneswswswswswwswswswswswnesw
#            sewnenwneneneenenenwnwnwwnwnenenenenwne swwnwswewswswnwswneswswwswswswwsesw wseenwseesewseesesesene
#            wsenweweeneeeneeneewseeeenee wswswwwswswwswswsweswwswnewswewsw wnewwwwnwseweswwswwwswwswwww
#            wnwswnwseswswwswwwewewwswnew senweeeeeeewsweneeneeeeee sweeseeseeneswenwenenwnwenesenenwsw
#            seenweseseseseseseseseseseesenewneswsese ewnweneeseeneeeeeneeeneenee nenwwsenwenwswnesewnwnenenesewswnene
#            sewseswswswseseswswsenwseseswsesesesene nesenenwswswseswsenwneswswswseewwsew
#            wnwnwnwnwwseeneneeswnewenwnwnwsenwne neneeneneswwneeenwneenee esenwenewneeweneneesesweesewe
#            nenwnwnwnenenwnwnwnesenwnewnw nwenwswenwnwnwnwswenwsenwnwnwnwwnenwwnw wnenesenenenwnesenwnwnenenesenene
#            eseeeeseewenenewnwsweeneenwee swswnewneseswseswwseneneneneswwswneswne enwenwwwswnwsenewe enwwswwseswwww
#            nwnwswswnenwnenwnenwnwnwsenenenenenenenenwe wswwneswsenwnwnewwsweew seswseseseseeesesenweesesewesesenwe
#            newswswswnenenwnwenenenwsenenwswnwwe nwneneeeneneneeswwenenenweeesesene
#            wneneneseeneneeswwneneneswnenenenenene nwneeneneewneneneneneneneneswnenene
#            nwnwneswnenwenewenenwnenewnwnesenene nwnenwenwswsenesesenwseneenwnwnwwnwsw swneweswswwwwswwwweseseneeww
#            nwwnenesesenenenenenwnenwnewneneenene sesenwswseseseseseswenwseswswseswsesese newneeneneeweseneewneneneweeee
#            newnwwswswwwswswwewesewwwwwnw nenwenenenewnwnenwnenwsenenenewnwnenwne
#            nwnenwsenwnenwnwnwnwnenwnenenesenewnwnene wnweswnwneenwwwsenwnwsenwenwsenesesw
#            enesenesenwwsweswneneswnenesenewswswnww nwnenwnesenwnenenenwnenenwseswnwnwnewnwnw
#            nwswseneseseseswseseswswsesewnwswseseesw nwnwnwnwnwwsenwnwnwsenesesewnw
#            neneneeneneeneneneenewnenenesenenenesw wsenenenwnenwnwnwwnenwnwsenwneenwnenww swwsenewneswseswnewww
#            wswnwswswseswswswsweseneneseeswswnesew seneenenewswneneneenenenenenenenenene wnwnwnwsewesenwwwnewwwesww
#            newswsewweenwewwnwswneeenwnwswnw neneneeswneneneneeeenene nwswwsenwwnwnwnweenwnwwewnwnwswnwne
#            nwnwnenwneeeenesewnwswswsenwnwnwwnw ewnwneswseneeneenweneseesenenenww nwnenenwnwenwnwnesewnenewnwswneseenene
#            neeweneneeneeneenenewneeeneneswse nwneswnwseseswswesewnwwswswswneesewe swswneswswsenwwswswwswswnwswswswswese
#            swswneswswenewsweneswwwswnwse eeeeseeeeeeseewenese wewwwseswwwswwwwnwewnwwwww
#            senwnwnwnwnwnenwwnenwswnwnwnenwnwnenwnwnw wwwsenwwswwweweswneswnwswwsww newwwwewwwwwwwewwwwwwse
#            eeneeeeeweneneeeeeneweee seseswneseswnewsewseseseneseneseseswsew seeswswseswswswswseswswswseswswwswnwse
#            sesewwseseseseseseneseseseesesesenwsese swewnwnenewswwewseswesenenwnwwnwwnw swenwseswwwswswwswswwwwenwnewsw
#            swsesenwesesesenesesenesenwsew swwswswwnwswwwswewswwnwswewwwe wswseeneswesewneswswwsewenew
#            swwsewnwwewwswwwnwwswswsw enweeeseneeeeneeeeee sweeeseeswenwenweeeeeeeeeee
#            sewnwnwswswseeswsweswswsweswswswswsenesw swwswwswswwswwneswwswswsw seswnewneenesenwnesenwweneeneswew
#            wnwesenwsenenweseseseswsesenesewswsene swwwwswwsewswwwneswwww wswwwswwswswewwwswwwewswwsw
#            esewswswswswswswnewswswneswswnwswseswsw nwsenwnwnesenenenenewnwnwnenenwnenenenene
#            swneneeneeseswnwneswwwneneenenenenenw swswswswwnwsweswswswswswesenwswswnesw
#            eswswswwwswswnwweswswswwnweswswswnw seneneneeeneeneewswneeeenenenee swswswswsesweswswswnewswswswswswswnesw
#            nwswnwewswwswwnwwneweenwnewnwe newseneswewnwseswnesesenwswneswswswse swwwwnwwewenenwwseww
#            swsewneswseseseseseswnwsesesewenenwese sewsesweewseneeeseeseeeweee eeeewneseeeeeeswneeesweswne
#            nenenwsewsenesesenwwwsenenwnwseneswnenww eeseesesesesewsesesesese newneenenwnesweseneneenenene
#            swswnwweswneseseswnwswseswseseswswswse nwswwnwsenweseswswseswswswsw nwwnwnwwnwwnwnesewnesewsenewnwwswnw
#            swnenwwnenenenenweseswsenenwenewnwswe nwnewnwseseswsewwneswneseseeswsesesenwse
#            nwwnwwswnwnenwnwnwnwwsenwenwnwnwnwsw seeseeesenwweeeneweseee nwwwwwwsewwwswnewwwwwwww
#            nwnwnwwwnwwwsewwneswnweewwsww esenwnenewnenenwnenenwnenweeseesenese wnenenenenenenwneenenenesenenenenenenew
#            eswneeneeeneeneswnenenwneeeeenee wswseswsenewswwnwswwwswswwwswnesw swswsesesenewswneseseswswwneswswsw
#            sesewswsenwswneenenenweswee seswswswswswswswneseswnwewswseswswswsw sesenwseseswswseswswsweseswswsenwsesesw
#            eswswswseswnwswswswswseseswswswnesewsesw enenweeneweneneeeesweenenesene esenenwneswsenweswwwnwnenwnwnwwnwwnw
#            swswesewswswswnwnwswwswswswweswswwsw seeseseseseneenwsesewnesenesewsesew eseswseseeswesenweenenweeseeeese
#            senwnwswwwwwwseseneswsewswswneswnw esenwwwseswseseneenwe swneswseseswseswneneswwswswswseswswswnwsw
#            swwwneswwswswswswneswesw nweeeneseseeeeeenenweeenwesw nesenwswnenwnwnwnwsenwneenenwnenenwnenw
#            neeeeeswneesewnenenwe swsesesesesesesesenesewsesesese]

floor = []
i = 0
while i < 100
  floor << [*Array.new(100, 'w')]
  i += 1
end

black_count = 0
input.each do |directions|
  i = 0
  start_x = 50
  start_y = 50
  dir_arr = []
  while i < directions.length
    case directions[i]
    when 'w', 'e'
      dir_arr << directions[i]
      i += 1
    when 'n', 's'
      dir_arr << "#{directions[i]}#{directions[i+1]}"
      i += 2
    end
  end

  dir_arr.each do |dir|
    start_x, start_y = move(start_x, start_y, dir)
  end

  if floor[start_x][start_y] == 'w'
    floor[start_x][start_y] = 'b'
    black_count += 1
    puts "end #{start_x} #{start_y} w -> b"
  else
    floor[start_x][start_y] = 'w'
    black_count -= 1
    puts "end #{start_x} #{start_y} b -> w"
  end
end

puts black_count
