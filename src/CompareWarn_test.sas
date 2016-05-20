*----- create test data -----;
data temp;
   do x = 1 to 10;
      y = x;
      output;
   end;
run;

data temp2;
   set temp;
   if x = 5 then 
      y = 6;
run;

data temp3;
   set temp;
run;


*----- load macro -----;
%let path = H:\GitHub\sas-comparewarn\src;
%include "&path\CompareWarn.sas";


*----- use macro on non-matching datasets -----;
proc compare base=temp compare=temp2;
run;
%CompareWarn();


*----- use macro on matching datasets -----;
proc compare base=temp compare=temp3;
run;
%CompareWarn();
