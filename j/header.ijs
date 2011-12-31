load 'csv'
NB. load 'tables/csv'

NB. read in the data
header_data=:readcsv '/home/cw/Dropbox/data/ResourceSheet.csv'

header=:0{header_data
data=:}.header_data

gnrs =: 0{"1 data
