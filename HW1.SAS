* PROCEDURES TO IMPORT DATASET;
data work.Airlines;
   infile "C:\Users\i037805\Desktop\INTRO TO R\1987_top100.csv" dlm=',' firstobs=2;
   input Year Month ArrTime UniqueCarrier$;
 run;  
 proc import out=work.Airlines1
       datafile= "C:\Users\i037805\Desktop\INTRO TO R\1987_top100.csv"
	   dbms=csv replace;
   getnames=yes;
   datarow=2;

run;
/********************************
Purpose: demonstrate importance of comments
Written By:Ruchita Trivedi
Date:Oct3,2015
*********************************/
data Stocks;
input StockSymbol$ Price Shares_Number ;
    value=Price*Shares_Number;
datalines;
AMGN 67.66 100
DELL 24.60 200
GE 34.50 100
HPQ 32.32 120
IBM 82.25 50
MOT 30.24 100

;
proc print data=Stocks;
run;

title "Average Price and No of Shares";
proc means data=Stocks;
   var Price Shares_Number;
run;
