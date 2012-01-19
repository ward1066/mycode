NB. =========================================================
NB.* oneYear (v) Generates all dates for one year
NB.
NB. y is: the Year
NB. returns: an n by 3 matrix of YYYY MM DD
oneYear=: verb define
NB. y is the year
year=. y
NB. First make a list of months and the last date of that month
months=. (12 1 $ >: i. 12),. 31 28 31 30 31 30 31 31 30 31 30 31
NB. Now handle the LEAP year ... rule is,
NB. its a leap year if its a modulos of 4
months=. (28 + (4 | year) = 0) (<1 1) } months
NB. Now for each month that we have, we create the dates
dates=. 0 2 $ 0
for_month. months do.
NB. Separate the month and the last day
  'month lastday'=. month
NB. Now generate all dates in that month
  dates=. dates, month,. >: i. lastday
end.
NB. Return the new calendar in YYYY MM DD format
year,. dates
)