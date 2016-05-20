/*----------------------------------------------------------------------------------------

*******************************************************
*** Copyright 2016, Rho, Inc.  All rights reserved. ***
*******************************************************

MACRO:   %CompareWarn

PURPOSE: Called immediately following a PROC COMPARE. Writes w@rning messages to the log 
         for non-zero return code values found in automatic macro variable SYSINFO.
         
SOURCE:  http://support.sas.com/resources/papers/proceedings12/063-2012.pdf
         Deciphering PROC COMPARE Codes: The Use of the bAND Function
         Joseph Hinson, Merck Sharp & Dohme Corp., Rahway, NJ
         Margaret Coughlin, Merck Sharp & Dohme Corp., Rahway, NJ
         SGF 2012

ARGS:    None.

RETURNS: None.

USAGE:   Call the macro immediately following a PROC COMPARE. If there is anything at 
         all unclean about the compare, you will get a w@rning in your log.
         
            proc compare base=derive.adsl compare=verify.v_adsl;
            run;
            
            %CompareWarn
         
NOTES:   If some of the below return codes are not of concern for your compare, make
         a local copy of the macro and limit the range of the do-loop for variable k.

PROGRAM HISTORY:         

Date        Programmer        Description
---------   ---------------   ------------------------------------------------------------
2016-04-07  Shane Rosanbalm   Original program.
2016-04-14  Shane Rosanbalm   Update put statement.
2016-05-04  Shane Rosanbalm   Add (sad meaningless) parens to the %macro statement.
2016-05-05  Shane Rosanbalm   Set scope of macro variable CompareCode.
         
----------------------------------------------------------------------------------------*/

%macro CompareWarn();

   %*--- capture &sysinfo before data _null_ wipes it out ---;
   %local CompareCode;   
   %let CompareCode = &sysinfo;
   
   data _null_;
      CompareCode = &CompareCode;
      %*--- all possible return code meanings for PROC COMPARE ---;
      array msg(16) $60 _temporary_ (
         "Data set labels differ",                       /* 1*/
         "Data set types differ",                        /* 2*/
         "Variable has different informat",              /* 3*/
         "Variable has different format",                /* 4*/
         "Variable has different length",                /* 5*/
         "Variable has different label",                 /* 6*/
         "BASE data set has observation not in COMPARE", /* 7*/
         "COMPARE data set has observation not in BASE", /* 8*/
         "BASE data set has BY group not in COMPARE",    /* 9*/
         "COMPARE data set has BY group not in BASE",    /*10*/
         "BASE data set has variable not in COMPARE",    /*11*/
         "COMPARE data set has variable not in BASE",    /*12*/
         "A value comparison was unequal",               /*13*/
         "Conflicting variable types",                   /*14*/
         "BY variables do not match",                    /*15*/
         "Fatal error: comparison not done"              /*16*/
         );
      %*--- use k= to exclude messages as needed ---;
      if CompareCode > 0 then do k = 1 to 16;
         match = band(2**(k-1),CompareCode);
         if match > 0 then 
            putlog 'WAR' 'NING: %CompareWarn detects: ' msg(k);
      end;
   run;

%mend CompareWarn;


