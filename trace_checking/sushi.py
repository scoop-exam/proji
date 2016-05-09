from stc import *

t = list(load_trace('sushi.trace'))
CAPACITY = 10

def endswith (s):
    return ap(s, t, lambda _, ap: ap.endswith(s))

def next_n (fi, n):
    return eventually(nnext(fi, [1, 1]), [n, n + 1])


def f1 ():
    '''
    If we are reached CAPACITY, then we are FULL
    '''
    return implies(endswith('({})'.format(CAPACITY)), nnext(endswith('FULL'), [1, 1]))

def f2 ():
    '''
    If we are FULL, then we have CAPACITY, CAPACITY - 1, ..., 0
    '''
    psi = [True] * len(t)
    for i in xrange(CAPACITY):
        psi = aand(psi, next_n(endswith('({})'.format(CAPACITY - i - 1)), i))

    return implies(endswith('FULL'), psi)

print f1.__doc__, all(f1())
print f2.__doc__, all(f2())
