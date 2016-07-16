PROC IMPORT OUT= WORK.D1 
            DATAFILE= "D:\FacDevSurvey\Data\s001_020.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D2 
            DATAFILE= "D:\FacDevSurvey\Data\s021_040a.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D3 
            DATAFILE= "D:\FacDevSurvey\Data\s041_060a.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D4 
            DATAFILE= "D:\FacDevSurvey\Data\s061_080.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D5 
            DATAFILE= "D:\FacDevSurvey\Data\s081_100.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D6 
            DATAFILE= "D:\FacDevSurvey\Data\s101_110.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D7 
            DATAFILE= "D:\FacDevSurvey\Data\s101_110.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D8 
            DATAFILE= "D:\FacDevSurvey\Data\s111_120.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D9 
            DATAFILE= "D:\FacDevSurvey\Data\s121_130.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D10 
            DATAFILE= "D:\FacDevSurvey\Data\s131_140.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D11 
            DATAFILE= "D:\FacDevSurvey\Data\s141_150.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D12 
            DATAFILE= "D:\FacDevSurvey\Data\s151_160.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D13 
            DATAFILE= "D:\FacDevSurvey\Data\s161_165.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D14 
            DATAFILE= "D:\FacDevSurvey\Data\s166_170.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
PROC IMPORT OUT= WORK.D15 
            DATAFILE= "D:\FacDevSurvey\Data\s171_175.txt" 
            DBMS=TAB REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;
*DATA ALLDATA;
*	SET D5;
*RUN;
*PROC PRINT DATA=ALLDATA;
*	ID SURVEYID;
*	VAR Q1CBOARD	;
*RUN;
DATA ALLDATA;
	SET D1 D2 D3 D4 D5 D6 D7 D8 D9 D10 D11 D12 D13 D14 D15;
	LABEL Q1AEMAIL='Q1a email' 
		Q1BWWW='Q1b www' 
		Q1CBOARD = 'Q1c Blackboard' 
		Q1DWORD = 'Q1d MS Word'
		Q1EPOINT = 'Q1e MS PowerPoint' 
		Q1FSMART = 'Q1f Smart Classroom' 
		Q1GWEBPG = 'Q1g Webpage Creation'
		Q1HTECHC = 'Q1h New tech tools for classroom use'
		Q1ITECHR = 'Q1i New tech tools for research'
		Q1JTECHA = 'Q1j New tech tools for assessment';
RUN;
PROC PRINT DATA=ALLDATA;
	ID SURVEYID;
	VAR Q3DDISCU	Q7APHOTO Q9DSKLAP	Q13SCHOL Q14POSIT;
RUN;
PROC FREQ DATA = D1;
	TABLES Q1AEMAIL	Q1BWWW	Q1CBOARD	Q1DWORD	Q1EPOINT	Q1FSMART	Q1GWEBPG	Q1HTECHC	Q1ITECHR	Q1JTECHA;
RUN;