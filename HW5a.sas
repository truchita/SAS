
*chapter 12, Ques 2;

data Mixed;
input Name & $15. ID  ;
datalines;
Daniel Fields   123
Patrice Helms   233
Thomas chien    998
;

data Mixed;
set work.mixed;
length First Last $7 ;
First = scan(Name,1,' ');
Last = scan(Name,-1,' ');
a= substr(First,1,1);
b=substr(Last,1,1);
keep NameLow NameProp NamewithoutProp;
NameLow= lowcase(Name);
NameProp = compbl(propcase(Name));
NamewithoutProp=catx(' ',(translate(First,upcase(a),a)) ,(translate(Last ,upcase(b),b))) ;
run;
proc print data=Mixed;
title"Names in three formats";
run;





*Chapter 12, Ques 6;
data work.study;
input Subj Group $  Dose  $  Weight $  Subgroup ;

datalines;

001 A Low 220lbs. 2
002 A High 90Kg. 1
003 B Low 88kg 1
004 B High 165lbs. 2
005 A Low 88kG 1

;
data Study;
set work.study;
Length Join $ 6;
Join = strip(Group)||'-'||strip(Dose) ;
catx = catx('-',Group,Dose);

run;
proc print data=Study;
title"concatinating";
run;

*chapter 12, Ques 13;
*Data set SOCIAL;

data social1;
input SS1 $11.;
datalines;
123-45-6789
001-34-9876
007-77-6767
102-43-9182
;
*Data set SOCIAL2;
data social2;
input SS2 $11.;
datalines;
123-45-6789
001-43-9876
007-77-6767
485-46-1182
102-43-9188
;
proc sql;
create table work.social as
select *
from social1, social2;
quit;


data exact within25;
set work.social;
Diatance = spedis(SS1,SS2);
if Distance eq 0 then output exact;
else if Distance lt 25 then output within25;
run;
proc print data=exact;
title"exact match";
run;
proc print data=within25;
title"match within diatance of 25";
run; 
 

*chapter 12, Ques 17;
*Data set PERSONAL;

data work.personal;
infile datalines missover;
input #1
SS $11.
Gender : $1.
AcctNum : $5.
DOB : mmddyy10.
#2 (Food1-Food8)(: $10.);
format DOB mmddyy10.;
label SS = "Social Security Number"
AcctNum = "Account Number"
DOB = "Date of Birth";
datalines;
123-45-6789 M 0192M 11/15/1949
Eggs Pancakes Sausage Toast Milk Coffee Beef Chicken
013-54-9388 F 9981S 1/2/1981
Pancakes Milk Chicken
112-11-1309 M 1322M 03/29/1988
Beef Toast Eggs Coffee
778-44-4655 F 9899M 7/4/1981
Pancakes Sausauge Coffee Beef
445-45-4455 M 2938S 8/9/1977
Tea Toast
;
data personal1;
set work.personal;
keep SS Gender AcctNum DOB;
a=substr(SS,1,7);
b=substr(AcctNum,5,1);
SS = translate (SS, '*' ,a);
AcctNum=translate (AcctNum, '-',b);
run;
proc print data=personal1;
title'hiding the essential info';
run;


*Chapter 13, Ques 3;
*Data set NINES;
data work.nines;
   infile datalines missover;
   input x y z (Char1-Char3)(:$1.) a1-a5;
datalines;
1 2 3 a b c 99 88 77 66 55
2 999 999 d c e 999 7 999
10 20 999 b b b 999 999 999 33 44
;
data nonines;
set work.nines;
array num_vars{*} $ _numeric_;
do i = 1 to dim(num_vars);
if num_vars{i} = 999 then call missing(num_vars{i});
end;
drop i;
run;
proc print data=nonines;
title'replacing 999 using arrays';
run;
