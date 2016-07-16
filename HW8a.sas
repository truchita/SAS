
*CHAPTER 19 , ques 4;
*Data set SURVEY;
libname learn 'c:\books\learning';
libname formats ('c:\books\learning');
options fmtsearch =(formats);
data learn.survey;
   infile 'c:\books\learning\survey.txt' pad;
   input ID : $3.
         Gender : $1.
         Age
         Salary
         (Ques1-Ques5)(1.);
run;

proc format library=formats;
   value $gender 'M' = 'Male'
                 'F' = 'Female'
                 ' ' = 'Not entered'
               other = 'Miscoded';
   value age low-29  = 'Less than 30'
             30-50   = '30 to 50'
             51-high = '51+';
   value $likert '1' = 'Strongly disagree'
                 '2' = 'Disagree'
                 '3' = 'No opinion'
                 '4' = 'Agree'
                 '5' = 'Strongly agree';
run;



ods rtf file='c:\books\learning\sample.rtf';
title "Listing of TEST_SCORES";
proc print data=learn.Survey;
title2 "Sample of HTML Output - all defaults";
id ID;
var  Ques1-Ques4;
run;
title "Descriptive Statistics";
proc means data=learn.Survey n mean min max;
var Ques1-Ques4;
run;
ods rtf close;
*Chapter 15, Ques 1;
libname learn 'c:\books\learning\learn';
option fmtsearch=(formats);
*Data set COLLEGE;
proc format library=formats;
   value $yesno 'Y','1' = 'Yes'
                'N','0' = 'No'
                ' '     = 'Not Given';
   value $size 'S' = 'Small'
               'M' = 'Medium'
               'L' = 'Large'
                ' ' = 'Missing';
   value $gender 'F' = 'Female'
                 'M' = 'Male'
                 ' ' = 'Not Given';
run;

data learn.college;
   length StudentID $ 5 Gender SchoolSize $ 1;
   do i = 1 to 100;
      StudentID = put(round(ranuni(123456)*10000),z5.);
      if ranuni(0) lt .4 then Gender = 'M';
      else Gender = 'F';
      if ranuni(0) lt .3 then SchoolSize = 'S';
      else if ranuni(0) lt .7 then SchoolSize = 'M';
      else SchoolSize = 'L';
      if ranuni(0) lt .2 then Scholarship = 'Y';
      else Scholarship = 'N';
      GPA = round(rannor(0)*.5 + 3.5,.01);
      if GPA gt 4 then GPA = 4;
      ClassRank = int(ranuni(0)*60 + 41);
      if ranuni(0) lt .1 then call missing(ClassRank);
      if ranuni(0) lt .05 then call missing(SchoolSize);
      if ranuni(0) lt .05 then call missing(GPA);
      output;
   end;
   format Gender $gender. 
          SchoolSize $size. 
          Scholarship $yesno.;
   drop i;
run;

title "Demographics from COLLEGE dataset";
proc tabulate data=learn.college;
class Gender Scholarship SchoolSize;

table Gender 
Scholarship ALL,
SchoolSize ;
keylabel ALL = 'Total'
          N=' ';
run;

*chapter 18, Ques 2;
title "Demographics from COLLEGE dataset";
proc tabulate data=learn.college;
class Gender Scholarship SchoolSize;

table SchoolSize ALL,  
Gender 
Scholarship ALL ;
keylabel ALL = 'Total'
          N=' ';
run;
*chapter 18 , Ques 3;

title "Demographics from COLLEGE dataset";
proc tabulate data=learn.college;
class Gender Scholarship SchoolSize;

table Gender  * Scholarship All,
SchoolSize ALL;
keylabel ALL = 'Total'
             N=' ';

run;

*chapter 18, Ques 6;
title "Descriptive Statistics";
proc tabulate data=learn.college;
class Gender;
var GPA ClassRank;
table GPA*( n*f=9.2  mean*f=9.1)
ClassRank*( n*f=comma9.1  mean*f=comma9.),
Gender ALL;
keylabel ALL = 'Total'
mean = 'Average'
n = 'Number';
run;

*chapter 20, Ques8;
%include "c:\books\learning\LibraryFile.txt";
data learn.fitness;
   call streaminit(13579246);
   do Subj = 1 to 100;
      TimeMile = round(rand('normal',8,2),.1);
      if TimeMile lt 4.5 then TimeMile = TimeMile + 4;
      RestPulse = 40 + int(2*TimeMile) + rand('normal',5,5);
      MaxPulse = int(RestPulse + rand('normal',100,5));
      output;
   end;
run;
title "Scatter Plot of Time Mile by rest pulse";
symbol value=dot height=3;
proc gplot data=learn.fitness;
plot TimeMile * RestPulse / haxis=60 to 70 by .3
vaxis=5 to 15 by .5;
run;
quit;

%include"c:\books\learning\LibraryFile.txt";
data learn.stocks;
   Do date = '01Jan2006'd to '31Jan2006'd;
      input Price @@;
      output;
   end;
   format Date mmddyy10. Price dollar8.;
datalines;
34 35 39 30 35 35 37 38 39 45 47 52
39 40 51 52 45 47 48 50 50 51 52 53
55 42 41 40 46 55 52
;
title "Scatter Plot of Price Vs Data";
title2 h=1.2 "Interprelation Methods";
symbol value=dot interpol=sms line=1 width=2;
proc gplot data=learn.stocks;
plot Price * Price;
run;
