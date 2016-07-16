options nodate nonumber nocenter formdlim="-";

/*************************************
     Setting up the data set
*************************************/
data hsb2;
  input  id female race ses prog
         read write math scinece socst;
datalines;
 70 0 4 1 1 57 52 41 47 57
121 1 4 2 3 68 59 53 63 61
 86 0 4 3 1 44 33 54 58 31
141 0 4 3 3 63 44 47 53 56
172 0 4 2 2 47 52 57 53 61
113 1 4 2 2 44 52 51 63 61
 50 0 3 2 1 50 59 42 53 61
 11 0 1 2 2 34 46 45 39 36
 84 0 4 2 1 63 57 54 51 63
 48 1 3 2 2 57 55 52 50 51
 75 1 4 2 3 60 46 51 53 61
 60 1 4 2 2 57 65 51 63 61
 95 0 4 3 2 73 60 71 61 71
104 0 4 3 2 54 63 57 55 46
 38 0 3 1 2 45 57 50 31 56
115 0 4 1 1 42 49 43 50 56
 76 0 4 3 2 47 52 51 50 56
195 0 4 2 1 57 57 60 56 52
;
run;

/**************************************************
      Macro variables
**************************************************/
proc means data = hsb2;
  var write math female socst;
run;
*The REG procedure fits least-squares estimates to linear regression models;
proc reg data = hsb2;
  model read = write math female socst;
run;
quit;

* defining a macro variable;
%let indvars = write math female socst;

* using a macro variable;
proc means data = hsb2;
  var &indvars;
run;
proc reg data = hsb2;
  model read = &indvars;
run;
quit;

*displaying macro variable value;
%put my first macro variable indvars is &indvars;

*displaying SAS system macro variables;
%put _automatic_;

*using macro variable in the title statement; 
title "today's date is &SYSDATE9 and today is &SYSDAY";
proc means data = hsb2;
  var &indvarS;
run;

*double quotes vs. single quotes;
title 'The date is &SYSDATE9 and today is &SYSDAY';
proc means data = hsb2;
  var &indvarS;
run;

title;
*displaying non-system macro variables;
%put _user_;

/********************************************
  Macro Functions
********************************************/

%put &indvars;

%let newind = %upcase(&indvars);
%put &newind;
%put;
* returns the second word from indvars list;
%let word2 = %scan(&indvars, 2);
%put &word2;
%put;

*returns the substring of indvars starting at position 5, and length of 3;
%let subword = %substr(&indvars, 5, 3);
%put &subword;
%put;

%let k = 1;
%let tot = &k + 1;
%put &tot;
%put;
*In the abov eprogram SAS treats &k+1 as string and not numbers thus, %eval does the evaluation;
%let tot = %eval(&k + 1);
%put &tot;
%put;

*%eval is only for integer evalution thus, %sysevalf(f for float)does evaluation on floating pt.however, it runs slower
for intense macos;
%let tot = %eval(&k + 1.234);
%let tot = %sysevalf(&k + 1.234);
%put &tot;
%put;

/********************************************
  symput and symget function
********************************************/
*to get the variable from data step into macro, n=n will simply count no of observations in out;
*example on symput;
proc means data = hsb2 n;
  var write;
  where write>=55;
  output out=w55 n=n;
run;
proc print data = w55;
run;
data _null_;
  set w55;
  call symput('n55', n);
run;
%put &n55 Observations have write >=55;

*example on symget. Here we are trying to get th evalue from a macro variable n55 into data step w55;
data hsb2_55;
  set hsb2;
  w55 = symget('n55')+0;*adding 0 converts character to numeric
run;
proc print data = hsb2_55;
  var write w55;
run;

/*********************************************
   Creating macro variables using proc sql
**********************************************/
proc sql;
  select sum(write>=55) into :w55
  from hsb2;
quit;
%put w55 is &w55;
proc sql;
  select mean(write) into :write1 - :write3
  from hsb2
  group by ses;
quit;
%put write1 to write3 are &write1, &write2 and &write3;


/**********************************************
  A macro program creating a list of files 
  for the set statement in a data step
***********************************************/

*creating fake data;
data file1 file2 file3 file4;
  input a @@;
  if _n_ <= 3 then output file1;
  if 3 < _n_<=  6 then output file2;
  if 6 < _n_ <= 9 then output file3;
  if 9 < _n_ <=12 then output file4;
cards;
1 2 3 4 5 6 7 8 9 10 11 12
;
run;

*normal way of stacking the four files together;
data all;
  set 
   file1 
   file2 
   file3 
   file4
  ;
run;

*defining macro program to combine all files;
%macro combine;
  data all_1;
    set
    %do i = 1 %to 4;
      file&i
    %end; 
    ;
  run;
%mend;

*the above steps just defined the macro, to run the macro program we need to call it like
options mprint shows the actual statements that SAS runs;

options mprint;
%combine

*checking;
proc print data=all_1;
run;

*modifying the first macro program so it will
 allow an argument (a parameter to pass to);

%macro combine(num);
  data big;
    set
    %do i = 1 %to &num;
      file&i
    %end; 
    ;
  run;
%mend;

*run the macro program to stack the first three
 files together;
%combine(3)

/***********************************
   An example of macro program 
   for a repetitive process
***********************************/

*creaing a fake data set;
data xxx;
  input v1-v5 ind1 ind2;
cards;
1 0 1 1 0 34 23
0 0 1 0 1 22 32
1 1 1 0 0 12 10
0 1 0 1 1 56 90
0 1 0 1 1 26 80
1 1 0 0 0 46 45
0 0 0 1 1 57 53
1 1 0 0 0 22 77
0 1 0 1 1 44 45
1 1 0 0 0 41 72
;
run;

title;
*regular SAS program to be based on.Logistic regression describes the relationship between a categorical response variable 
and a set of predictor variables. A categorical response variable can be a binary variable, an ordinal variable or a 
nominal variable;
proc logistic data = xxx descending;
  model v1 = ind1 ind2;
run;

* a macro program that does it:
  dependent variables have to be named
  v1, v2, etc;
%macro mylogit(num);
  %do i = 1 %to &num;
    title "dependent variable is v&i";
    proc logistic data=xxx des;
      model v&i = ind1 ind2;
    run;
  %end;  
%mend;
%mylogit(5)

/*******************************************
  setting up system options for 
  debugging macro programs
  use of %put statement for debugging
*******************************************/

options mprint mlogic;
%macro mylogit(num);
  %do i = 1 %to &num;
     title "dependent variable is v&i";
     proc logistic data=xxx des;
       model v&i = ind1 ind2;
     run;
  %end;
  %put &i;
%mend;
*executing the macro using 5 dependent variable;
%mylogit(5)


* first modification so to allow 
  a list of dependent variable names
k will pull out first, second and so on dependent variables from list all_deps untill dep is empty;
%macro mylogit1(all_deps);
  %let k=1;
  %let dep = %scan(&all_deps, &k);
  %do %while("&dep" NE "");
    title "dependent variable is &dep";
    proc logistic data=xxx des;
      model &dep = ind1 ind2;
    run;
    %let k = %eval(&k + 1);
    %let dep = %scan(&all_deps, &k);
  %end;
%mend;
*run the program for the frist three v's;
%mylogit1(v1 v2 v3)

* second modification to allow both a list 
  of dependent variable list and an output
  data set for parameter estimates;
%macro mylogit1(all_deps, outest);
  %let k=1;
  %let dep = %scan(&all_deps, &k);
  %do %while("&dep" NE "");
    title "dependent variable is &dep";
    proc logistic data=xxx des outest=_est&k;
      model &dep = ind1 ind2;
    run;
    %let k = %eval(&k + 1);
    %let dep = %scan(&all_deps, &k);
  %end;

  %if "&outest" NE "" %then 
  %do;
    data &outest;
      set 
      %do i = 1 %to &k - 1;
        _est&i
      %end; 
      ;
    run;
  
    %let k = %eval(&k - 1);
    proc datasets;
      delete _est1 - _est&k;
    run;
  %end;
  %else 
  %do;
    %put no dataset name was provided, files are not combined;
  %end;
%mend;


*run the program for the first three v's;
%mylogit1(v1 v2 v3)
*run the program for the first three vs and
 saving the parameter estimates to a data set;
%mylogit1(v1 v2 v3, a)
proc print data = a;
  var intercept ind1 ind2;
run;

/*************************************************
  Further modification of the macro program:
  -- input data set;
  -- list of dependent variables
  -- list of independent variables
  -- output data set for parameter estimates
**************************************************/
%macro mylogita(indata, all_deps, indvars =, myout =_out );
  %let k=1;
  %let dep = %scan(&all_deps, &k);
  %do %while(&dep NE);
    title "The dependent variable is &dep";
    title2 "The independent variables are &indvars";
    proc logistic data=&indata des outest=est&k;
      model &dep = &indvars;
    run;
    %let k = %eval(&k + 1);
    %let dep = %scan(&all_deps, &k);
  %end;

  data &myout;
    set 
    %do i = 1 %to &k - 1;
      est&i
    %end; 
    ;
  run;
%mend;

*run the program;
%mylogita(xxx, v1 v2 v3, indvars = ind1 ind2, myout = myparms)

title;
proc print data = myparms;
  var _name_ intercept ind1 ind2;
run;

* run the program again: unpositional arguments can be reordered;
%mylogita(hsb2,female, myout = myparm1, indvars = write math)

title;
proc print data = myparm1;
  var _name_ intercept write math;
run;

