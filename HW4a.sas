*chapter 10, ques1;
data work.blood;
infile 'c:\books\learning\blood.txt' truncover;
length Gender $ 6 BloodType $ 2 AgeGroup $ 5;
input Subject
Gender
BloodType
AgeGroup
WBC
RBC
Chol
combined;
combined=(WBC+RBC)/100;
run;

data division1 division2;
set work.blood;
if  gender= 'Female' and bloodtype ='AB' and not missing(combined) then  do;
    if combined lt 14 then output division1;
    else if combined ge 14 then  output division2;
end;
proc print data=division2;
run;
*chapter 10, Ques2;

data monday_2002;
set work.monday2002;
if weekday(admitdate)=2 and year(admitdate)=2002 then output monday_2002;

run;


data monday_2002;
set work.monday_2002;
Age=round(yrdif(DOB,Admitdate,'actual'));
proc print data=work.monday_2002;
title"age of patients born on monday ,2002";
run;

* chapter 10, ques 3;
data lowmale lowfemale;
set work.blood;
if missing(chol) then delete;
if gender = 'Male' and chol lt 100  then output lowmale;
else if gender = 'Female' and chol lt 100 then output lowfemale;
run;
proc print data=lowmale  ;
title "males and females with low chol";
run;
proc print data=lowfemale;
run;






