/*  Create a Stored Compiled Macro      */
/*      in One Session                  */
libname mylib 'u.macro.mysecret' disp=old;
options mstored sasmstore=mylib;
%macro myfiles / store;
  filename file1 'work.SFdatabase';
  filename file2 'work.SFdatabase2';
%mend;

/*  Use the Stored Compiled Macro       */
/*       in a Later Session             */
libname mylib 'u.macro.mysecret' disp=shr;
options mstored sasmstore=mylib;

%myfiles
data _null_;
   infile file1;
     proc sort data = file1 out=file2;
by EP;
run;  
	 

   file file2;
   run;
     
run;
