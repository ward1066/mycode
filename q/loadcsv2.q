/to load this file us \l ../Users/uk80674/Dropbox/q/loadcsv2.q (no quotes needed)
/To save a file to csv...assume you have a table called mytable
/save ':/q/data/mytable.csv

fork: {[f;g;h;x] g[f[x];h[x]]}
averg: fork[+/;%;#:;]

/Load a file called ResourceSheet.csv into a table called resourcesheet...
table: ("SSSSSSSIDIIIIIIIIIIIDIIIIIIIIIIS"; enlist ",") 0:`:/home/adminuser/git/mycode/q/data/ResourceSheet.csv
resource:table
show thecols:flip enlist cols resource
show "1"
select GNR,Scope from resource where GNR = `GNR83000195
/Make the GNR the primary key
show "2"
`GNR xkey resource
thePhases:`Phase xasc (distinct select Phase from resource)
show "3"

sumhrs:select InitTotHours:sum InitialTotalHours by resource.Phase from resource 
/where Phase = `04 Pending
show sumhrs

show "4"

/List all the tables in existence
tables `.


/establish a test dictionary and a table
/d1:`the name`the salary! (`tom`dick`harry;30 30 35)
/t1:flip d


/Associate a key column with values
/values:flip `name`iq!(`Dent`Beeblebrox`Prefect;98 42 126) 
/k:flip (enlist `eid)!enlist 1001 1002 1003
/kt:k!values  /simply associate these with the values

