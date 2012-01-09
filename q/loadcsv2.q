/to load this file us \l ../Users/uk80674/Dropbox/q/loadcsv2.q (no quotes needed)
/To save a file to csv...assume you have a table called mytable
/save ':/q/data/mytable.csv

/Load a file called resourcesheet.csv into a table called resourcesheet...
table: ("SSSSSSSIDIIIIIIIIIIIDIIIIIIIIIIS"; enlist ",") 0:`:/Users/uk80674/Dropbox/data/resourcesheet.csv
resource:table
show thecols:flip enlist cols resource
select GNR,Scope from resource where GNR = `GNR83000195

/Make the GNR the primary key
`GNR xkey resource
thePhases:`Phase xasc (distinct select Phase from resource)

/establish a test dictionary and a table
/d1:`the name`the salary! (`tom`dick`harry;30 30 35)
/t1:flip d


/Associate a key column with values
/values:flip `name`iq!(`Dent`Beeblebrox`Prefect;98 42 126) 
/k:flip (enlist `eid)!enlist 1001 1002 1003
/kt:k!values  /simply associate these with the values

