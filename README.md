Sick and tired of having to look at your output to determine whether not your `PROC COMPARE` ran cleanly? 

Introducing the `%CompareWarn` macro! 

It slices, it dices, it writes `WARNING` messages to your log if anything went wrong with your `PROC COMPARE`. For instance:
```
proc compare base=dataset_one compare=dataset_two;
run;
%CompareWarn();
```
If the `BASE` dataset has more records than the `COMPARE` dataset, the log message will be:
```
WARNING: %CompareWarn detects: BASE data set has observation not in COMPARE
```
If there are any unequal values between the two datasets, the log message will be:
```
WARNING: %CompareWarn detects: A value comparison was unequal
```
If something catastrophic happens and the compare crashes, the log message will be:
```
WARNING: %CompareWarn detects: Fatal error: comparison not done
```

The code for this macro is based on a [paper](http://support.sas.com/resources/papers/proceedings12/063-2012.pdf) from SGF 2012. The paper uses the `BAND` function to interrogate the `SYSINFO` automatic macro variable. If anything at all goes wrong with the compare, this macro will find it.
