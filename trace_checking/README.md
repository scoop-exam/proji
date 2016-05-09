To perform trace checking you should, first of all, get the [Simple Trace Checker](https://github.com/affo/stc):

```
# in any directory you want

$ git clone https://github.com/affo/stc.git
```

Then you can get the trace of the problem you want to analyze:

```
# from SCOOP project root
# for problem 'prob'

$ ./make.sh prob
$ ./prob.out > prob.trace
```

And, finally, write and run your script:

```
# in the same directory that contains stc

$ touch prob.py

# write your trace checking script
# as in one of the examples

$ source trace_checking/checkingrc
$ python prob.py
```
