Model parameters
----------------

n
    Number of particles
idim
    Matrix dimension
ibond
    Number of bonds
E(4)
    Eigenvalues (four lowest)
list1(idim)
    Particle configurations. ``s`` = list1(j) denotes state with serial number ``j``.
list2(2, 0:2**15)
    Inverse table of list1. let s = (ib)(ia), then serial number ``j`` is given
    by ``j = list2(1, ia) + list2(2, ib)``
bondwt(ibond)
    :math:`J_{ij}`. Exchange interaction
ipair(ibond*2)
    :math:`<i, j>`. Lattice structure
zrtio(ibond)
    :math:`\Delta{ij}`. Anisotropy parameter
szval
    :math:`S_z^{total}`. Total spin momentum
ic
    :math:`ic=ibond+1` 
    Maximum number of nonzero matrix elements in a row, including diagnoal term.
elm2.elemnt(idim, ic)
    *Values* of nonzero matrix element in Hamiltonian matrix
    H[i, loc[i, j]] = elemnt[i, j]
    element[i, j] (j<ic) denotes off-diagonal element from ipair[2j-1] and
    ipair[2j]
    element[i, j] (j=ic) denotes diagonal element.
elm2.loc(idim, ic)
    *Locations* of nonzero matrix element in Hamiltonian matrix
    H[i, loc[i, j]] = elemnt[i, j]
elm3.elemnt(idim, idim)
    Full matrix elements.

Computational parameters
------------------------

E(4)
    Four lowest eigenvalues
nvec
    Number of eigenvectors to be calculated [0, 4].
x(idim, nvec)
    ``nvec`` eigenvectors with lowest eigenvalues
iv
    Specifies initial random vector with ``iv``\ th component set to 1.
wk(idim, 2)
    working area necessary to calculate eigenvectors in lncv. Needs ``4`` for inv. 
itr
    Iteration steps for convergence in Lanczos method.
Hexpec
    :math:``<x|H|x>``. Eigenvalue from obtained vector ``x``


Configuration generator
-----------------------

sz szdy sztn
    call sz(n, idim, szval, list1, list2)
    Generate two lists (list1 and list2) to store particle configurations and
    their serial numbers in matrix.


Matrix storage
--------------

small.for
    elemnt(idim, idim), which stores the full matrix
    subroutine ``elm3``: calculates matrix elements
medium.for
    elemnt(idim, ic), which stores only nonzero matrix elements
    ic specifies 
    subroutine ``elm2``: calculates nonzero matrix elements
large.for
    *No* matrix element stored, with only matrix-vector multiplication
    (``multiply``)
    No subroutine to store matrix elements


Eigenvalues
-----------


Eigenvectors
------------

lncv
    Able to obtain up to four lowest eigenvectors with decreasing precison for higher
    states.
inv
    Able to obtain any specific eigenvector with higher precison. Needs more
    working space and CPU time. One eigenvector at a time.

Precision check
---------------

check1 check2 check3
    Precision check for obtained eigenvector and corresponding eigenvalue
