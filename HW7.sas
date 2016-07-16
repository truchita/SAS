*Chapter 15, Ques 1;
libname learn 'c:\books\learning\learn';
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

title "College data not- mising and missing satistical summary by Gender";
proc means data=learn.college n nmiss mean median
min max maxdec=2;
class Gender;
var ClassRank GPA;
run;

*Chapter 16, Ques 2;
libname learn 'c:\books\learning';
libname formats 'c:\books\learning';
options fmtsearch=(formats);


proc means data=learn.college noprint chartype;
class Gender SchoolSize;
var GPA ClassRank;
output out = ClassSummary
mean =
n = / autoname;
run;
title"Class Summary ";
proc print data=ClassSummary;
run;
*You can also use this summary data set to create separate data sets: one for the grand
mean, one for means broken down by Gender, one broken down by AgeGroup, and one
containing cell means;
data Grand(drop = Gender SchoolSize)
by_gender(drop = SchoolSize)
by_schoolsize(drop = Gender)
cellmeans;
set ClassSummary;
drop _type_;
rename _freq_ = Number;
if _type_ = '00' then output Grand;
else if _type_ = '01' then output by_Gender;
else if _type_ = '10' then output by_schoolsize;
else if _type_ = '11' then output cellmeans;
run;


*Chapter 16, Ques 3;

proc sort data=learn.college out=college;
by SchoolSize;
run;
proc means data=college noprint;
by SchoolSize;
var GPA ClassRank;
output out = many_stats
mean = M_GPA M_ClassRank
median = Med_GPA Med_ClassRank;
run;
title" GPA and ClassRank Statistics using BY";
proc print data=many_stats ;
run;
proc means data=college noprint;
class SchoolSize;
var GPA ClassRank;
output out = many_stats
mean = M_GPA M_ClassRank
median = Med_GPA Med_ClassRank;
run;
title" GPA and ClassRank Statistics using CLASS";
proc print data=many_stats ;
run;


*chapter 17, Ques 5;
libname learn 'c:\books\learning\learn';
libname formats 'c:\books\learning';
options fmtsearch=(formats);
proc format;
value Class_Rank
low-<71 = '70 and lower'
71-high = '71 and higher';

run;
title "Using Formats to Create Groups";
proc freq data=learn.college;
tables Scholarship*ClassRank  ;
format ClassRank Class_Rank.;
run;
