*Chapter 14 , Ques 2;
proc sort data=work.sales out=sales1;
by Region;
run;
title "Adding Totals and Subtotals to Your Listing";
proc print data=sales1 label;
by Region;
id EmpID;
var TotalSales Quantity;
sum Quantity TotalSales;
label EmpID = "Employee ID"
TotalSales = "Total Sales"
Quantity = "Number Sold";
format TotalSales dollar10.2 Quantity comma7.;
run;


*chapter 14, Ques 3;
data hosp;
set work.hosp;
if missing (Subject) then delete;
proc sort data=work.hosp;
by Subject;
run;

title3 "Selected patients from hosp dataset admitted in Sep2004 and older than 83 years";
title4 "-------------------------------------------------------------------------------";

     
proc print data=work.hosp(obs=5) double n="Number of patients:" label ;
id subject;
var  AdmitDate DischrDate DOB;
label AdmitDate="Admission Date"
DischrDate="Date of Discharge"
DOB="Date of Birth";
format AdmitDate DischrDate DOB mmddyy10.2;
run;


*chapter 15, Ques: 1;

*Data set BLOOD;
data work.blood;
   infile 'c:\books\learning\blood.txt' truncover ;
   length Gender $ 6 BloodType $ 2 AgeGroup $ 5;
   input Subject 
         Gender 
         BloodType 
         AgeGroup
         WBC 
         RBC 
         Chol;
   
run;


title " Blood Data Set";
proc report data=work.blood(obs=5) nowd headline;
column Subject WBC RBC;
define Subject / display "Subject Number" width=7;
define WBC / "White Blood Cells" width=6 format=comma6.0;
define RBC / "Red Blood Cells" width=5 format=5.2;
run;
quit;


*Chapter 15, Ques 4;
*Data set BLOODPRESSURE;
data work.bloodpressure;
   input Gender : $1. 
         Age
         SBP
         DBP;
datalines;
M 23 144 90
F 68 110 62
M 55 130 80
F 28 120 70
M 35 142 82
M 45 150 96
F 48 138 88
F 78 132 76
;
title"Hypersensitive Patients";
proc report data=work.bloodpressure ;


column Gender Age SBP DBP Hypersensitive;
define Gender / display "Gender"   width=7;
define Age / "Age" group  width=6 ;
define SBP / display "SBP" group  width=5 ;
define DBP / display "DBP" group width=5 ;
define Hypersensitive /"Hypersensitive ? " computed width=6;
compute Hypersensitive / character length=6;
if  Gender eq 'F' and (SBP gt 138 or  DBP gt 88) then Hypersensitive = 'YES' ;
else if Gender eq 'F' and (SBP le 138 or  DBP le 88) then Hypersensitive = 'NO' ;
else if Gender eq 'M' and (SBP gt 140 or  DBP gt 90) then Hypersensitive = 'YES' ;
else if Gender eq 'M' and (SBP le 140 or  DBP le 90) then Hypersensitive = 'NO' ;


endcomp;
run;

* Chapter 15, Ques;

title"Patient Age Groups";
proc report data=work.bloodpressure ;
column  Age Gender AgeGroup;
define Age / display "Age" width=7;
define Gender / "Gender" width=6 ;
define AgeGroup/ "Age Group" width=5 ;
compute AgeGroup / character length=4;
if Age ge 50 then AgeGroup ='>50';
else AgeGroup= '<=50';
endcomp;
run;






