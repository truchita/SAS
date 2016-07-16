data ques1;
infile 'c:\books\learning\ques1.txt';
input Gender: $1
      Weight1 Weight2 Weight3 Weight4 ;
AveScore = mean(of Weight1-Weight4);
run;

title "Listing of data set ques1";
proc print data=ques1;
run;


*q:2;
data votes;
infile datalines dsd;
input Stater $ Party $  Age;
datalines;

"NJ",Ind,55
"CO",Dem,45
"NY",Rep,23
"FL",Dem,66
"NJ",Rep,34
;
title "dataset-Votes";
proc print data=votes;
run;
proc freq data=votes;
table party;
run;



*ch3,q7: reading raw data from fixed coloumns;

data geocaching;
infile 'c:\books\learning\geocaching.txt';
input Name : $ 1-20
LongDeg  21-22
LongMin  23-28
LatDeg 29-30
LatMin  31-36
;
run;
















*ch3, q10:reading a formatted input from fixed  coloumn  and calculating additional variables;

data stocks;
infile 'c:\books\learning\stockprices.txt';
input @1 Stock $4.
@5 PurDate mmddyy10.
@15 PurPrice DOLLAR5.
@21 Number 4.
@25 SellDate mmddyy10.
@35 SellPrice DOLLAR5.;
TotalPur=Number*PurPrice;
TotalSell=Number*SellPrice;
Profit=TotalSell-TotalPur ;

run;


title "Listing of Stocks";
proc print data=stocks;
var TotalPur TotalSell Profit;
run;




* Ch4 q1: creating a permanent datafile
Listing All the SAS Data Sets in a SAS
Library Using PROC CONTENTS ;

libname learn 'c:\books\learning';
data learn.perm;
input ID : $3. Gender : $1. DOB : mmddyy10.
Height Weight;
label DOB = 'Date of Birth'
Height = 'Height in inches'
Weight = 'Weight in pounds';
format DOB date9.;
datalines;
001 M 10/21/1946 68 150
002 F 5/26/1950 63 122
003 M 5/11/1981 72 175
004 M 7/4/1983 70 128
005 F 12/25/2005 30 40
;

title "The Descriptor Portion of Data Set perm";
proc contents data=learn.perm varnum;
run;





*ch4 Q2: comparing the results of PROC PRINT and VIEWTABLE in the Data Portion of SAS dataset
You can drag and drop columns, sort, or hide columns using your mouse, very much as
you do with an Excel spreadsheet.;
title "Listing of perm";
proc print data=learn.perm;
run;
