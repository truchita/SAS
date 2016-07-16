* proc SQL for data manipulation;

*Data set HEALTH;
data health;
   input Subj : $3.
         Height
         Weight;
datalines;
001 68 155
003 74 250
004 63 110
005 60 95
;

*Data set DEMOGRAPHIC;
data demographic;
   input Subj : $3.
         DOB : mmddyy10.
         Gender : $1.
         Name : $20.
         Weight : 3.;
   format DOB mmddyy10.;
datalines;
001 10/15/1960 M Friedman 45	
002 8/1/1955 M Stern 87
003 12/25/1988 F McGoldrick 93
005 5/28/1949 F Chien 56
;
proc sql; 
  create table FullOuterJoin as
  select  *
  from Health, Demographic
  where Health.Subj=demographic.Subj
  order by Health.Subj;
quit;

proc print data=FullOuterJoin;
run;
title'Creating group means and save them into a sequence of SAS macro variables';
proc sql noprint; 
   select mean(Weight) into :meanweight from Demographic;
quit;
%put &meanweight;
proc sql noprint;  
   select mean(Weight) into :meanweight1 - :meanweight3 from Demographic
   group by Subj;
quit;
%put _user_; 
data test;
  set Demographic;
  difference = Weight - &meanweight;
run;

proc print data=test;
run;
