load 'pacman'

NB. Update the server catalog
'update' jpkg ''

NB. Example usage
'install' jpkg 'convert/misc'
'install' jpkg 'data/jdb'
'install' jpkg 'csv'
'install' jpkg 'convert/misc tables/csv'
'install' jpkg 'base library'
'install' jpkg 'math/misc base library stats/base'  NB. "base library" is specially handled
'install' jpkg 'math/misc';'base library';'stats/base'

NB. Install all packages
'install' jpkg 'all'

NB. Check tjhe status
'status' jpkg ''
