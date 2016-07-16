*Program 5-6 Creating a permanent format library;
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

*Program 5-7 Adding label and format statements in the DATA step;
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
title "Data set SURVEY";
proc contents data=learn.survey varnum;
run;
PROC PRINT DATA =WORK.VOTER;
RUN;
