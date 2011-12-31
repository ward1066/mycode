load 'csv'
NB. load 'tables/csv'

NB. read in the data
alldata=:readcsv '/home/cw/Dropbox/data/ResourceSheet.csv'

NB. read in the data
header_data=:readcsv '/home/cw/Dropbox/data/ResourceSheet.csv'

header=:0{header_data
data=:}.header_data

NB. Extract gnrs from the table
gnrs =: 0{"1 data

require 'data/jdb strings'
coinsert 'jdb'

sel_parse=: 3 : 0
  t=. 2{.' by ' splitstring y
  c=. (<',') splitstring^:(0<#@]) each t
  'r b'=. (<':') (_2 {. splitstring)^:(0<#@]) every L:1 c
  'ra re'=. <"1 |:r
  'rf rc'=. <"1 |:(<' ') (_2 {. splitstring)^:(0<#@]) every re
  'ba bc'=. <"1 |:b
  ra ; rf ; rc ; ba ,&<  bc
)

Note 'Test sel_parse'
  hd=. (;:'ra rf rc ba bc') ,: ]
  hd sel_parse 'a,b,c'
  hd sel_parse 'a,b,c by qq,zz'
  hd sel_parse 'q:a,b,x:c'
  hd sel_parse 'a,q:b,c by qq,z:zz'
  hd sel_parse 'sum a,q:avg b,min c by qq,z:zz'
)

NB. Create database and tables
hf=: Open_jdb_ '/home/cw/temp'
hd=: Create__hf 'mydb'
ht=:Create__hd 'mytable'

NB. Fields are of type "SSSSSSSIDIIIIIIIIIIIDDIIIIIIIIISIS"
InsertCols__hd 'mytable';0 : 0
tno int;
gnr varchar;
scope varchar
assignee varchar
valuestream varchar
marketsegment varchar
status varchar
phase varchar
pwin int
reqdate int
priority int
initialduration int
initialtotalhours int
initialstructureshours int
initialavenghours int
initialavinshours int
initialweightshours int
initialstresshours int
initialotherhours int
initialtechpubshours int
pcntcompletefromactuals int
eststartdate int
remainingduration int
percentcomplete int
remainingtotal int
remainingstructures int
remainingavionicseng int
remainingavionicsins int
remainingweights int
remainingstress int
remainingother int
remainingtechpubs int
firmness varchar
pcntcompleteworkorder int
)
