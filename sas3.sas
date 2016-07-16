data work.pricegroup;
   set  Sashelp.cars;
   length Catoegory $ 10;
   xyz=MSRP-Invoice;
   if xyz<15 then Catoegory='Cheap';
   else Catoegory='Inflated';
run;


proc print data=Sashelp.Cars;
format Weight dollar10.2;
run;

proc freq data=Sashelp.Cars  ;
table Origin;

proc sort data=Sashelp.Cars out= work.Car;
   by Origin;
