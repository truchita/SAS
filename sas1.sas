data Work.LungCapData;
    infile 'C:\Users\i037805\Desktop\INTRO TO R\LungCapDataCSV.csv'  dlm=',' firstobs=2 ;
    input Age Height Smoke$ Gender Caesarean$;
run;
proc import out = work.LungCap
        datafile= 'C:\Users\i037805\Desktop\INTRO TO R\LungCapDataCSV.csv'
        dbms=csv replace;
    getnames=yes;
    datarow=2;
run;
run;
	
