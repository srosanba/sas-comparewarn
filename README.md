Sick and tired of having to look at the output to figure out whether not your `PROC COMPARE` ran cleanly!? Introducing the `%CompareWarn` macro! It slices, it dices, it writes `WARNING` messages to your log if anything went wrong with your `PROC COMPARE`. For instance:
```
proc compare base=dataset_one compare=dataset_two;
run;
%CompareWarn();
```
If the `BASE` dataset has more records than the `COMPARE` dataset, the log message will be:
```
WARNING: %CompareWarn detects: BASE data set has observation not in COMPARE
```
The code for this macro is based on a [paper](http://support.sas.com/resources/papers/proceedings12/063-2012.pdf) from SGF 2012. The code uses the `BAND` function to interrogate the `SYSINFO` automatic macro variable. If anything at all goes wrong with the compare, this macro will find it.
