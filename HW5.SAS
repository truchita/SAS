*chapter 11, Ques 1.
round()and int()both are truncation functions;

data work.health;
input Subj : $3.
Height
Weight
;

BMIR=round((Weight/(2.2))/((Height*(.0254))**2));
BMITEN=round((Weight/(2.2))/((Height*(.0254))**2),.1);
BMI5=round((Weight/(2.2))/((Height*(.0254))**2),5);
BMItrunc=int((Weight/(2.2))/((Height*(.0254))**2));
datalines;
001 68 155
003 74 250
004 63 110
005 60 95
;
proc print data=work.health;
title"differnt numeric trucation functions";
run;


*chapter 11, Ques5;
data work.Evaluate;
input ID : $3. Ques1-Ques10 Score1-Score5;

if n(of Ques1-Ques10) ge 3 then ScoreAve = mean(largest(1,of Ques1-Ques10),largest(2,of Ques1-Ques10),largest(3,of Ques1-Ques10));
if n(of Ques1-Ques10) ge 7 then QuesAve=mean(of Ques1-Ques10);
Composit= (ScoreAve+(10*QuesAve));
datalines;

001 1 3 2 4 5 4 3 4 5 4 90 92 93 90 88
002 3 3 . . 3 4 5 5 1 . 95 . . 86 85
003 . . . . 5 5 4 4 3 3 88 87 86 85 84
004 5 3 4 5 . 5 4 3 3 . 78 78 82 84 .
005 5 4 3 2 1 1 2 3 4 5 92 93 94 95 99

;
proc print data=work.Evaluate;
title"Marks Evaluation";
run;
              


*Chapter 11,Ques8 ;
data random;

 do i=1 to 1000;
    random_int = int(ranuni(0) * 5 + 1);
    output;
 end;
run;
proc freq data=random;
tables random_int;
title"chackin uniform random generator";
run;
proc freq data=random;
tables random_int;
title"checking uniform random generator";
run;


