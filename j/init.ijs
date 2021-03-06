NB. load '../Dropbox/j/projects/wininit.ijs'

load 'general/jod'

NB. the command below shows the list of scripts to be loaded when j next starts
startupscripts =: (,. 10 {. 4 !: 3 '')

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
NB. load mncodeu
NB. mn ''  NB. open the mnemonic form editor


SuAx =: <
Sel =: <
Excl =: <
Nada =: 0$0


NB. Select all rows (:a) from column 3 in the table
(SuAx (Sel a:), (Sel 3)) { data

NB. Select from row 0 all columns except column 1
(SuAx (Sel 0), (Sel (Excl Nada))) { data
NB. We can select all things on a particular axis by excluding nothing, that is, giving an 
NB. empty list (0$0) as a list of thing-numbers to exclude. For example, to select from A elements at row 1, all columns:
(SuAx (Sel 1),(Sel (Excl 0$0))) { data

NB. (Excl 0$0) denotes empty list


NB.  Set which plane, row and column to select from an array
myarray =: 10 + i. 3 3 3
p =: 0 1
r =: 1
c =: 2

NB. These next two are equivalent
(SuAx p;c;r) { myarray
(SuAx (Sel p),(Sel c),(Sel r)) { myarray





NB. load loadcsv

NB. ln =: labnext_jlab_ ''
