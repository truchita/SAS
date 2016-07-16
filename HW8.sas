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
