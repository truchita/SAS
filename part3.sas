

/* Set the graphics environment */
goptions reset=all border cback=white htitle=12pt; 

 /* Create the data set HAT */
data hat;
   do x=-5 to 5 by 0.25;
      do y=-5 to 5 by 0.25;
         z=sin(sqrt(x*x+y*y));
         output;
      end;
   end;
run;

 /* Define a title for the plot */
title1 'Surface Plot of HAT Data Set';

 /* Create the plot */
proc g3d data=hat;
   plot y*x=z;
run;
quit;
* Answer 4---rotate the graph by 25 degrees;
proc g3d data=hat;
  plot y*x=z /
  rotate=25 tilt=80;
run;

******Extra Credit: Answer 3: Bivariate normal distribution plot;
/* Set the graphics environment */
goptions reset=all border cback=white htitle=12pt; 
title'Bivariate Normal Density';
 %let r=0.9;

/* Create the data set HAT */
data hat;
pi=3.146;
   do x1=-4 to 4 by 0.1;
      do x2=-4 to 4 by 0.1;
         phi=exp(-(x1*x1-2*&r*x1*x2+x2*x2)/2/(1-&r*&r))/2/pi/sqrt(1-&r*&r);

         output;
      end;
   end;
run;

 /* Define a title for the plot */
title1 'Bivariate Distribution Plot';

 /* Create the plot */
proc g3d data=hat;
   plot x1*x2=phi;
   run;
   quit;



