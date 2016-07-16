* compute frequencies
make a simple 2 way chi-square table
supress the legends like cumulative , percentage etc
for list out put put /list or for /crosslist;
proc freq data=sashelp.cars;
table Origin*Make /nocum nopercent;
*or table Origin*Make/list;
run;

title"simple bar chart "
proc sgplot data=sashelp.cars;
hbar= Make /response =MSRP stat= mean;
run;
