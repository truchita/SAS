* here we make the macros permanent in the learn library. we can simply copy paste the sasmacr frlder 
in learn to make it permanent;
libname  learn 'c:\books\learning\';
options mstored sasmstore=learn;
%macro mylogita  / store source des='mylogita';

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
