# sas-comparewarn
This repository contains a SAS macro for checking the SYSINFO macro variable following a PROC COMPARE to determine whether or not the compare is clean. 
```
proc compare base=derive.adsl compare=verify.v_adsl;
run;
%CompareWarn();
```
If anything at all is wrong with your compare, the macro will write a `WARNING` to your SAS log. For instance, if the `BASE` dataset has more records than the `COMPARE` dataset, the log message will be:
```
WARNING: %CompareWarn detects: BASE data set has observation not in COMPARE
```
