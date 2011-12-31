NB. load '../Dropbox/j/projects/wininit.ijs'

atype=: 3 : 0
select. #$y
case. 0 do. 'scalar'
case. 1 do. 'vector'
case. do. 'array of dimension greater than 1'
end.
)

m0=: /:~ 					NB. Sort the array y in ascending order
m1=: \:~ 					NB. Sort the array y in descending order
m2=: /:~"_1 				NB. Sort the items of array y ascending
d3=: /:@:{ { [ 				NB. Sort indices x according to y
d4=: ]/:{"1 				NB. Sort table y according to column x
d5=: \:@[`(/:@[) @. ] 		NB. Grade x up if y is 1 and down if y is 0
d6=: \:~@[`(/:~@[) @. ] 	NB. Sort up or down (Try literal argument)
d7=: /:~ 					NB. Sort y according to x

sortbycol =:d4

NB. Define an array of variables
NB. abca
NB. bcab
NB. cabc
a1=:3 4 $ 'abc'

NB. box the array elements
NB. a b c a
NB. b c a b 
NB. c a b c
a2=:<"0 a1

NB. Remove the last column
NB. a b c 
NB. b c a  
NB. c a b 
a3=:3{."1 a2

NB. now sort by column2
NB. c a b 
NB. a b c 
NB. b c a  

NB. now sort by column3
NB. b c a  
NB. c a b 
NB. a b c 

load mnemonics1
NB. load mncode
load mncodeu
NB. mn ''  NB. open the mnemonic form editor

NB. load loadcsv

ln =: labnext_jlab_ ''
