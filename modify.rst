TITPACK modifications
---------------------

Tiny modifications to meet my requirement and f2py.

* f2py directives ``!f2py intent(intent) list`` will be added after subroutine
  header lines, whose default value is ``intent(in)``.

* 

common.for
~~~~~~~~~~

* sz

  * ``if(icnt.eq.idim)`` -> ``if(icnt <= idim)``
    not suitable for undetermined idim, when *symmetry* is involved

  * *XXX* ``list2(2,0:2**15)`` -> ``list2(2,0:2**((n+1)/2)-1)`` 
    seems like exponent not work well in arrary index in f2py (only pow() in C)
