*chapter 6 ques1;
proc import 
  datafile="C:\books\learning\drugtest.xlsx" 
  dbms=xlsx 
  out=work.drugtest 
  replace;
run;
proc print data=work.drugtest;
title 'drugtest';
run;


*chapter 6 ques2;
data soccer;
input Team : $20. Wins Losses;
datalines;
Readington 20 3
Raritan 10 10
Branchburg 3 18
Somerville 5 18
;
options nodate nonumber;
title;
ods listing close;
ods csv file='c:\books\learning\soccer.csv';
proc print data=soccer noobs;
run;
ods csv close;
ods listing;
proc import 
  datafile="C:\books\learning\soccer.xls" 
  dbms=xls 
  out=sasuser.soccer 
  replace;
run;

*chapter 6 ques 3 This will not work for me becoz my MS office 365 is 32 bit , not compatible with 64 bit SAS
So when dealing with excell files convert to csv first.Thus the error
ERROR: Connect: Class not registered
ERROR: Error in the LIBNAME statement.
;
libname PCFILES "c:\books\learning\soccer.xls";

run;
title "reading excell worskheet(without importing) using an xls engine ";
proc print data=sasuser.'soccer$'n ;
dbms = xls
run;


* chapter 5 , ques1;

data voter;
input Age Party : $1. (Ques1-Ques4)($1. + 1);
label Ques1=' The president is doing a good job'
Ques2=' Congress is doing a good job'
Ques3 ='Taxes are too high'
Ques4 ='Government should cut spending';
datalines;
23 D 1 1 2 2
45 R 5 5 4 1
67 D 2 4 3 3
39 R 4 4 4 4
19 D 2 1 2 1
75 D 3 3 2 3
57 R 4 3 4 4
;
proc format;
value age low-30  = 'Less than 30'
             31-50   = '30 to 50'
             51-70   = '51 to 70'
             71-high = '71+' ;
   value $ party D   =' Democrat '
                 R   ='Republican '; 
   value $likert '1' = 'Strongly disagree '
                 '2' = ' Disagree '
                 '3' = ' No opinion '
                 '4' = 'Agree '
                 '5' = 'Strongly agree '  ;
run;
proc print data=voter ;
title "proc print with LABEL";
label;
run;

proc freq data=voter;
title "Question Frequencies ";
tables Ques1-Ques4;

run;



*chapter5, Ques:2
regrouping values using a format and applying new formats to several variables(questions here);
proc format;
value $three '1','2' = 'Disagreement'
'3' = 'No opinion'
'4','5' = 'Agreement';
run;
proc freq data=voter;
title "Question Frequencies Using the $three Format";
tables Ques1-Ques4;
format Ques1-Ques4 $three.;
run;


*chapter 5 , ques:3;

*using proc freq on format names;
data colors;
input Color : $1. @@;
datalines;
R R B G Y Y . . B G R B G Y P O O V V B
;
proc format;
value$colorfmt  'R', 'B', 'G' = 'Group 1'
'Y', 'O' = 'Group 2'
' Missing' = 'Not Given'
'others' = 'Group 3' ;
                   

title "freq";
proc freq data=colors;
title "color frequencies";

format Color $colorfmt.;
run;

*chapter 5, ques:4;

*Creating a permanent format library;
libname myfmts 'c:\books\learning\formats';

proc format library=myfmts;

value age low-30  = 'Less than 30'
             31-50   = '30 to 50'
             51-70   = '51 to 70'
             71-high = '71+' ;
   value $ party D   =' Democrat '
                 R   ='Republican '; 
   value $likert '1' = 'Strongly disagree '
                 '2' = ' Disagree '
                 '3' = ' No opinion '
                 '4' = 'Agree '
                 '5' = 'Strongly agree '  ;
run;

* Adding label and format statements in the DATA step;
libname learn 'c:\books\learning\formats';
options fmtsearch=(myfmts);

data voter;
input Age Party : $1. (Ques1-Ques4)($1. + 1);
label Ques1=' The president is doing a good job'
Ques2=' Congress is doing a good job'
Ques3 ='Taxes are too high'
Ques4 ='Government should cut spending';
datalines;
23 D 1 1 2 2
45 R 5 5 4 1
67 D 2 4 3 3
39 R 4 4 4 4
19 D 2 1 2 1
75 D 3 3 2 3
57 R 4 3 4 4
;
run;

*Program 5-8 Running PROC CONTENTS on a data set with labels and formats;
title "permanent";
proc contents data=learn.voter varnum;
run;
PROC PRINT DATA =WORK.VOTER;

RUN;



*CHAPTER 7, QUES 1:;
data school;
input Age Quiz : $1. Midterm Final;
if Age eq 12 and not missing(age) then grade = 6;
else if Age eq 13  then grade = 8;
if Quiz eq 'A' then grade_marks=95;
else if Quiz eq 'B' then grade_marks=85;
else if Quiz eq 'C' then grade_marks=75;
else if Quiz eq 'D' then grade_marks=70;
else if Quiz eq 'F' then grade_marks=60;
course =.2*grade_marks+.30*midterm+.50*Final;
datalines;
12 A 92 95
12 B 88 88
13 C 78 75
13 A 92 93
12 F 55 62
13 B 88 82
;

proc print data=school;
title 'student marksheet';
run;


