data newvitals;
input ID : $3.
Age
Pulse
SBP
DBP;

label SBP = "Systolic Blood Pressure"
DBP = "Diastolic Blood Pressure";
if missing(Age) then delete;
if Age lt '50' then do;
   if Pulse lt '70' then Pulse_group='low';
   else  Pulse_group= 'high';
   if SBP lt '130' then SBP_group='low';
   else  SBP_group='high';
end;
else if Age gt '50' then do;
   if Pulse lt '74' then Pulse_group='low';
   else  Pulse_group='high';
   if SBP lt '140' then SBP_group='low';
   else  SBP_group='high';
end;


datalines;
001 23 68 120 80
002 55 72 188 96
003 78 82 200 100
004 18 58 110 70
005 43 52 120 82
006 37 74 150 98
007 . 82 140 100
;

   

proc print data=work.vitals noobs  ;
title 'new vitals';
     
run;



*chapter 8, Ques: 2;

data monthsales;
input month sales @@;
sum_sales+sales;
	output;
	
datalines;
1 4000 2 5000 3 . 4 5500 5 5000 6 6000 7 6500 8 4500
9 5100 10 5700 11 6500 12 7500
;
proc print data=monthsales;
title'total up to date';
run;

*Chapter 8  , Ques 7;
data equation;
do X = 0 to 10 by .10;
Y = (3*x**2) - (5*x) + 10;
output;
end;
run;
symbol value=none interpol=sm width=2;
title "Plot of Y versus X";
proc gplot data=equation;
plot Y * X;
run;

*Chapter 8 , Ques 8;
data  work.logitplot;
do p = 0 to 1 by .05;
Logit = log(p / (1 - p));
output;
end;
run;
symbol value=none interpol=sm width=2;
title "Plot of Y versus X";
goptions reset=all
ftext='arial'
htext=1.0
ftitle='arial/bo'
htitle=1.5
colors=(black);
symbol v=none i=sm;
title "Logit Plot";
proc gplot data=logitplot;
plot Logit * p;
run;
quit;

*Chapter 8 , Ques 11;
data Temperatures;
do Group = 'Dallas','Houston';
do Hour = 1 to 24;
input Temperature @;
output;
end;
end;
datalines;
80 81 82 83 84 84 87 88 89 89
91 93 93 95 96 97 99 95 92 90 88
86 84 80 78 76 77 78
80 81 82 82 86
88 90 92 92 93 96 94 92 90
88 84 82 78 76 74
;
proc print data=Temperatures;
title'Temperatures for Dallas and Houston';
run;

* Chapter 8, Ques 13, do while (Total le 30000), gives same result;
data Compound;
Interest = .0425;
Total = 1000;
do untill (Total ge 30000);
Year + 1;
Total = Total + Interest*Total;
output;
end;
format Total dollar10.2;
run;
proc print data=Compound noobs;
title "Listing of Amount compounded Quaterly";
run;



* chapter 9 , Ques 8;
data dates;
   
   input day$ month$ year$;
   datalines;
25 12 2005
1 1 1960
21 10 1946
;
data dates;
set work.dates;
Date = mdy(Month, Day, Year);
format Date mmddyy10.;
run;
proc print data=dates;
title'mdy example';
run;

*Chapter 9, Ques 9;
data dates;
   
   input day$ month$ year$;
   datalines;
25 12 2005
. 5 2002
12 8 2006
;
data substitute;
set work.dates;
if missing(day) then Date = mdy(Month,15,Year);
else Date = mdy(Month,Day,Year);
format Date mmddyy10.;
run;
proc print data=substitute;
title'Substitute missing date with 15';
run;
