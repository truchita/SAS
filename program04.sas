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
/* -------------------------------------------------------------- */
PROC FORMAT;
	VALUE CONFFMT 1 = 'NOT CONFIDENT' 2 = 'LOW CONFIDENT' 3 = 'CONFIDENT' 4 = 'HIGH CONFIDENT';
	VALUE INTERFMT 1 = 'NOT INTERESTED' 2 = 'LOW INTEREST' 3 = 'INTERESTED' 4 = 'HIGH INTEREST';
	VALUE COURSFMT 1 = 'NO COURSES' 2 = 'SOME COURSES' 3 = 'ALL COURSES';
	VALUE USEFMT 1 = 'NEVER' 2 = 'SOMETIMES' 3 = 'OFTEN' 4 = 'ALWAYS';
	VALUE NY12FMT 1 = 'NO' 2 = 'YES';
	VALUE NY01FMT 0 = 'NO' 1 = 'YES';
	VALUE $COMPFMT 'DESK' = 'DESKTOP' 'LAP' = 'LAPTOP';
	VALUE $SCHFMT 'ALSS' = 'ALSS' 'SCI' = 'SCIENCE' 'BUS' = 'BUSINESS' 'EDU' = 'EDUCATION';
	VALUE $POSFMT	'LEC' = 'LECTURER' 'TT' = 'TENURE TRACK' 'TEND' = 'TENURED';
RUN;
DATA ALLDATA;
	SET D1 D2 D3 D4 D5 D6 D8 D9 D10 D11 D12 D13 D14 D15;
	LABEL Q1AEMAIL='Q1a confidence email' 
		Q1BWWW='Q1b confidence www' 
		Q1CBOARD = 'Q1c confidence Blackboard' 
		Q1DWORD = 'Q1d confidence MS Word'
		Q1EPOINT = 'Q1e confidence MS PowerPoint' 
		Q1FSMART = 'Q1f confidence Smart Classroom' 
		Q1GWEBPG = 'Q1g confidence Webpage Creation'
		Q1HTECHC = 'Q1h confidence New tech tools for classroom use'
		Q1ITECHR = 'Q1i confidence New tech tools for research'
		Q1JTECHA = 'Q1j confidence New tech tools for assessment'
		Q2AEMAIL = 'Q2a interest email'
		Q2BWWW = 'Q2b interest www'
		Q2CBOARD = 'Q2c interest Blackboard'
		Q2DPOINT = 'Q2d interest MS PowerPoint'
		Q2EWORD = 'Q2e interest MS Word'
		Q2FSMART = 'Q2f interest Smart Classroom'
		Q2GWEBPG = 'Q2g interest Webpage Creation'
		Q2HTECHC = 'Q2h interest New tech tools for classroom use'
		Q2ITECHR = 'Q2i interest New tech tools for research'
		Q2JTECHA = 'Q2j interst New tech tools for assessment'
		Q3AANOUN = 'Q3a bb announcements'
		Q3BSYLLA = 'Q3b bb syllabus'
		Q3CLINKS = 'Q3c	bb links'
		Q3DDISCU = 'Q3d bb threaded discussions'
		Q3EDRPBX = 'Q3e bb digital drop box'
		Q3FTEST = 'Q3f bb assessment, quiz, test'
		Q3GGRADE = 'Q3g bb grade book'
		Q3HGROUP = 'Q3h bb groups'
		Q3ICHAT = 'Q3i bb chat'
		Q4AHELP = 'Q4a Help Desk'
		Q4BINFO = 'Q4b IT'
		Q4CLIBRY = 'Q4c Library'
		Q4DFACDV = 'Q4d	Office of Fac Dev'
		Q4EDEPAR = 'Q4e Depart, School Staff'
		Q4FCOLEG = 'Q4f colleagues'
		Q5AOWN = 'Q5a on your own'	
		Q5BWRKSH = 'Q5b workshop'	
		Q5CCDROM = 'Q5c cdrom manual'	
		Q5DSTFIT = 'Q5d IT staff'	
		Q5ESTFSC = 'Q5e School staff'	
		Q5FSTFLI = 'Q5f Library staff'	
		Q5GSTFFD = 'Q5g FacDev staff'	
		Q6AHOME	= 'Q6a home'
		Q6BCSUH	= 'Q6b CSUH office'
		Q6COTHER = 'Q6c another location'	
		Q7APHOTO = 'Q7a photo'	
		Q7BCONTA = 'Q7b contact info'	
		Q7COFFIC = 'Q7c office hours'	
		Q7DINTRS = 'Q7d res teach interest'	
		Q7EPUBLS = 'Q7e recent pubs projs activities'
		Q7FLINKS = 'Q7f links'	
		Q8AAUTO	= 'Q8a auto gen'
		Q8BEDIT	= 'Q8b can edit'
		Q8CCREAT = 'Q8c create own'	
		Q8DNOPAG = 'Q8d not interested'	
		Q9DSKLAP = 'Q9 computer type'	
		Q10WRKSH = 'Q10 attend workshop'	
		Q11WIFI	= 'Q11 wireless internet'
		Q12ONLIN = 'Q12 teach online'	
		Q13SCHOL = 'Q13 school teach in'	
		Q14POSIT = 'Q14 position'	
		Q15AWEB	= 'Q15a web' 
		Q15BCAMP = 'Q15b campus mail'	
		Q15CEMAI = 'Q15c email'	
		Q15DVIEW = 'Q15d The View'	
		Q15ENOWH = 'Q15e nowhere'	
		Q16COMM = 'Q16 additional comments';
	FORMAT Q1AEMAIL -- Q1JTECHA CONFFMT.
			Q2AEMAIL -- Q2JTECHA INTERFMT.
			Q3AANOUN -- Q3ICHAT COURSFMT.
			Q4AHELP	-- Q4FCOLEG Q5AOWN -- Q5GSTFFD Q6AHOME Q6BCSUH Q6COTHER USEFMT.
			Q7APHOTO -- Q7FLINKS NY12FMT.
			Q8AAUTO Q8BEDIT Q8CCREAT Q8DNOPAG Q10WRKSH Q11WIFI Q12ONLIN Q15AWEB -- Q15ENOWH Q16COMM NY01FMT.
			Q9DSKLAP $COMPFMT.
			Q13SCHOL $SCHFMT.
			Q14POSIT $POSFMT.
RUN;
PROC PRINT DATA=ALLDATA;
	ID SURVEYID;
	VAR Q1AEMAIL Q3DDISCU Q7APHOTO Q9DSKLAP Q13SCHOL Q14POSIT Q16COMM;
RUN;
PROC PRINT DATA=ALLDATA;
	ID SURVEYID;
	VAR Q1AEMAIL Q3DDISCU Q7APHOTO Q9DSKLAP Q13SCHOL Q14POSIT Q16COMM;
RUN;
/* REMOVE ALL 99 FROM THE NUMERIC VARIABLES*/
/* SEE CH.15 CODY AND SMITH*/
DATA ALLDATAN;
	SET ALLDATA;
	ARRAY MISSN[*] _NUMERIC_;

	DO I = 1 TO DIM(MISSN);
		IF MISSN[I] = 99 THEN
			MISSN[I] = .;
	END;
	
	DROP I;
RUN;
PROC PRINT DATA=ALLDATAN;
	ID SURVEYID;
	VAR Q1AEMAIL Q3DDISCU Q7APHOTO Q9DSKLAP Q13SCHOL Q14POSIT Q16COMM;
RUN;
/* REMOVE ALL 99 FROM THE CHARACTER VARIABLES*/
/* SEE CH.15 CODY AND SMITH*/
DATA ALLDATAM;
	SET ALLDATAN;
			 			 
	IF Q9DSKLAP = '99' THEN Q9DSKLAP = ' ';
	IF Q13SCHOL = '99' THEN Q13SCHOL = ' '; 
	IF Q14POSIT = '99' THEN Q14POSIT = ' '; 
RUN;
PROC PRINT DATA=ALLDATAM;
	ID SURVEYID;
	VAR Q1AEMAIL Q3DDISCU Q7APHOTO Q9DSKLAP Q13SCHOL Q14POSIT Q16COMM;
RUN;
/* -------------------------------------------------------------- */
PROC FREQ DATA = ALLDATAM;
	TABLES Q1AEMAIL -- Q1JTECHA Q2AEMAIL -- Q2JTECHA Q3AANOUN -- Q3ICHAT
	Q4AHELP	-- Q4FCOLEG Q5AOWN -- Q5GSTFFD Q6AHOME Q6BCSUH Q6COTHER
	Q7APHOTO -- Q7FLINKS Q8AAUTO Q8BEDIT Q8CCREAT Q8DNOPAG	Q9DSKLAP
	Q10WRKSH Q11WIFI Q12ONLIN Q13SCHOL Q14POSIT 
	Q15AWEB -- Q15ENOWH Q16COMM;
RUN;
/* CONFIDENCE VERSUS INTEREST */
PROC FREQ DATA = ALLDATAM;
	TABLES Q1AEMAIL*Q2AEMAIL Q1BWWW*Q2BWWW 
			Q1CBOARD*Q2CBOARD Q1DWORD*Q2DWORD 
			Q1EPOINT*Q2EPOINT Q1FSMART*Q2FSMART
			Q1GWEBPG*Q2GWEBPG Q1HTECHC*Q2HTECHC
			Q1ITECHR*Q2ITECHR Q1JTECHA*Q2JTECHA/ CHISQ;
RUN;
/* COMPUTER TYPE VERSUS SCHOOL*/
PROC FREQ DATA = ALLDATAM;
	TABLES Q9DSKLAP*Q13SCHOL Q9DSKLAP*Q14POSIT / CHISQ;
RUN;
/* -------------------------------------------------------------- */
/* SOME BAR CHARTS */
PROC CHART DATA = ALLDATAM;
	HBAR Q1AEMAIL -- Q1JTECHA /LEVELS=4;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q2AEMAIL -- Q2JTECHA /LEVELS=4;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q3AANOUN -- Q3ICHAT /LEVELS=3;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q4AHELP	-- Q4FCOLEG /LEVELS=4;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q5AOWN -- Q5GSTFFD /LEVELS=4;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q6AHOME Q6BCSUH Q6COTHER /LEVELS=4;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q7APHOTO -- Q7FLINKS /LEVELS=2;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q8AAUTO Q8BEDIT Q8CCREAT Q8DNOPAG /LEVELS=2;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q9DSKLAP;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q13SCHOL;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q14POSIT;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q9DSKLAP / GROUP=Q13SCHOL;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q9DSKLAP / GROUP=Q14POSIT;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q10WRKSH /LEVELS=2;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q11WIFI /LEVELS=2;
RUN;
PROC CHART DATA = ALLDATAM;
	HBAR Q12ONLIN /LEVELS=2;
RUN;























































