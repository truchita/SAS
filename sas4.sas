*sorting sas dataset in ascending or decsending order of variables;
proc sort data=sashelp.cars out=work.cars1;
by descending Cylinders  descending Horsepower;
run;
* print a simpler version of list by manipulating no. og observations , removing the unordered observation 
coloums;
proc print data=sashelp.cars(obs=25) noobs;
var Origin Type MSRP EngineSize;
where Origin=Asia;
run;

*here proc means lists the statistical values of MSRP for all levels of class make and origin.
note that the N shows the missing values and N Obs stands for all values.;
proc means data=sashelp.cars max min mean maxdec=2; *these override the statistical values 
and precision is upto 2 decimals.

var MSRP;
class Make Origin ;
run;
