*imported the .csv file via import wizard We got errors while import although the dataset got imported completely
NOTE: Invalid data for DepTime in line 1952 13-14.
NOTE: Invalid data for ArrTime in line 1952 21-22.
NOTE: Invalid data for ActualElapsedTime in line 1952 40-41.
NOTE: Invalid data for ArrDelay in line 1952 49-50.
NOTE: Invalid data for DepDelay in line 1952 52-53.
We dint bother these errors as they were because of left-aligned NA s for numeric variables in 
Excell sheet ,SAS replaced them with periods(.), and they will be ignored in PROC MEANS procedure ;


* cleaning the Character variables;
data Flight;
set Flight;
array char_vars{*} $ _character_;
do loop = 1 to dim(char_vars);
if char_vars{loop} in ('NA' '?') then
call missing(char_vars{loop});
end;
drop loop;
run;


proc format ;
value Monthfmt
1='Jan'
2='Feb'
3='Mar'
4='Apr'
5='May'
6='Jun'
7='July'
8='Aug'
9='Sept'
10='Oct'
11='Nov'
12='Dec';


run;

data Flight1;
set Flight;
Char_Month = put(Month,Monthfmt.);
Dep_Hour= int(DepTime/100);
CRSDep_Hour= int(CRSDepTime/100);
Arrival_Hour= int(ArrTime/100);
CRSArr_Hour= int(CRSArrTime/100);
drop Month DepTime ArrTime CRSDepTime CRSArrTime;
run;

* Part2, Answer 3.	Make tables of counts and relative frequencies for the Categorical variables for each month of 1987. ;
title"relative Freq/Counts for all Character variables by Month";
proc freq data=Flight1 ;
table Char_Month *(_character_) / nocol norow ;*table Char_Month *(UniqueCarrier Origin Dest) / nocol norow;
output out=Flight_char;
run;

ods rtf file='c:\books\learning\part3.rtf';
proc freq data=Flight1 ;
table Char_Month *(Origin Dest) / nocol norow ;
output out=Flight_char;
run;
ods rtf close;

proc freq data=Flight1 ;
table Char_Month * (DayofWeek DayofMonth Dep_Hour CRSDep_Hour Arrival_Hour CRSArr_Hour)/nocol norow; 
output out=Flight_char1;
run;
    
run;


* Answer 4-----Proc MEANS using Class;
title"Mean and Standard Daviation of all Numeric Variables";
proc means data=Flight1 mean std  ;
class Char_Month;
output out=Flight_num;
var Year ActualElapsedTime CRSElapsedTime ArrDelay DepDelay Distance Cancelled Diverted ;

run;


run;
******Extra credit:comressing the Flight dataset. Note : compress all data sets created within a SAS sessions:
options (compress=yes);
data Flight1 (compress=yes);
 set Flight1;
 
