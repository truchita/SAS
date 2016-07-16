PROC IMPORT OUT= WORK.FOUR_DATES 
            DATAFILE= "C:\books\learning\hosp_Suess.xls" 
            DBMS=EXCEL4 REPLACE;
     GETNAMES=YES;
RUN;
