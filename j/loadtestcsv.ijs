load 'csv'
NB. load 'tables/csv'

NB. ------ define the headers ----------
NB. colNext 'XXX No is 'XXX NoGNR160=:1
NB. colDESIGNGNR=:2
NB. colScopeofWork:=3
NB. colAssignedto=:4
NB. colValueStream(Legacy)=:5
NB. colMarketSegment=:6
NB. colStatus=:7
NB. colPhase=:8
NB. colContractAwardDate=:9
NB. colDateofClosure-Billing=:10
NB. colHourlyRate=:11
NB. colLabourBookedCost=:12
NB. colPartsBookedCost=:13
NB. colServiceBookedCost=:14
NB. colExpensesBookedCost=:15
NB. colSoldHours=:16
NB. colTotalCosttoBillToCustomer=:17
NB. colPWin=:18
NB. colT&MJob=:19
NB. col"RequiredBy"Date=:20
NB. col(Appliestobids,businesscasesandcontractedwork)=:21
NB. colPriority=:22
NB. colEstimateIssueDate=:23
NB. colOnTrack=:24
NB. colOriginalEstimatedDuration(weeks)=:
NB. colOriginalEstimatedTotal=:
NB. colOriginalEstimatedHoursStructures=:
NB. colOriginalEstimatedHoursAvionicsEng=:
NB. colOriginalEstimatedHoursAvionicsInst=:
NB. colOriginalEstimatedHoursWeights=:
NB. colOriginalEstimatedHoursStress=:
NB. colOriginalEstimatedHoursOther=:
NB. colOriginalEstimatedHoursTechPubs=:
NB. col%Completeaccordingtoactualsbookings(ifontrack)=:
NB. colForecastStartDate(TodaysdateforWIP)=:
NB. colForecastRemaingDuration(weeks)=:
NB. colCalculatedEndDate=:
NB. colRemainingEstimatedTotal=:
NB. colStructures=:
NB. colAvionicsEng=:
NB. colAvionicsInst=:
NB. colWeights=:
NB. colStress=:
NB. colOther=:
NB. colTechPubs=:
NB. colFirmness=:
NB. colWorkordercomplete%=:
NB. colRelatedtoChangeorPaintSpec=:
NB. colComments=:
NB. colActivity=:
NB. colDesignGNR-YearOpen.=:
NB. colInvoiced=:
NB. colCustomer=:
NB. colA/CInputDate=:
NB. colA/COutputDate=:
NB. colSerial=:
NB. colReg=:
NB. colType=:
NB. colEstimateNo=:
NB. colEstimateIssue=:
NB. colEstimateDateIn=:
NB. colEstimateDateOut=:
NB. colEstimateEnquirySource=:
NB. colEstimateDuration=:
NB. colEstimateMonth=:
NB. colEstimateYear=:
NB. colTotalBookedRAL(Excluding9100No)=:
NB. colBookedStructures=:
NB. colBookedAvionicsEng=:
NB. colBookedAvionicsInst=:
NB. colBookedWeights=:
NB. colBookedStress=:
NB. colBookedOther=:
NB. colBookedTechPubs=:
NB. colRemainingHours=:
NB. colDaysLefttoStartDate=:
NB. colNotContractedorclosed=:
NB. colContractedorNPT=:
NB. colIncludeinForecast?=:

NB. read in the data
NB. alldata=:readcsv projectpath`'data/rawdata.csv'
alldata=:readcsv projectpath`'data/test.csv'
header_data=:alldata


header=:0{header_data
data=:}.header_data

NB. Select all rows (:a) from column 3 in the table
(SuAx (Sel a:), (Sel colStartDate)) { data


NB. Extract gnrs from the table
col1 =: 0{"1 data

require 'data/jdb strings'
coinsert 'jdb'
NB. 
sel_parse=: 3 : 0
   t=. 2{.' by ' splitstring y
   c=. (<',') splitstring^:(0<#@]) each t
   'r b'=. (<':') (_2 {. splitstring)^:(0<#@]) every L:1 c
   'ra re'=. <"1 |:r
   'rf rc'=. <"1 |:(<' ') (_2 {. splitstring)^:(0<#@]) every re
   'ba bc'=. <"1 |:b
   ra ; rf ; rc ; ba ,&<  bc
)
NB. 
NB. Note 'Test sel_parse'
  NB. hd=. (;:'ra rf rc ba bc') ,: ]
  NB. hd sel_parse 'a,b,c'
  NB. hd sel_parse 'a,b,c by qq,zz'
  NB. hd sel_parse 'q:a,b,x:c'
  NB. hd sel_parse 'a,q:b,c by qq,z:zz'
  NB. hd sel_parse 'sum a,q:avg b,min c by qq,z:zz'
NB. )
NB. 
NB. NB. Create database and tables
NB. hf=: Open_jdb_ 'temp'
NB. hd=: Create__hf 'mydb'
NB. ht=:Create__hd 'mytable'
NB. 
NB. NB. Fields are of type "SIID"
NB. InsertCols__hd 'mytable';0 : 0
NB. name varchar;
NB. age int;
NB. shoesize varchar
NB. dateofbirth int
NB. )
NB. 