from stc import *

t = list(load_trace('bathroom.trace'))

truth_f = lambda sym, ap: ap.startswith(sym)

man_in = ap('man.in', t, truth_f)
woman_in = ap('woman.in', t, truth_f)

def f1 ():
    '''
    A man can enter only if there is no woman inside
    '''
    return implies(nnext(man_in, [1, 1]), nnot(woman_in))

def f2 ():
    '''
    A woman can enter only if there is no man inside
    '''
    return implies(nnext(woman_in, [1, 1]), nnot(man_in))

print f1.__doc__, all(f1())
print f2.__doc__, all(f2())
