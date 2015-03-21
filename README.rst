Model parameters
----------------

n
    Number of particles
szval
    :math:`S_z^{total}`. Total spin
ipair(ibond*2)
    :math:`<i, j>`. Lattice structure
bondwt(ibond)
    :math:`J_{ij}`. Exchange interaction
zrtio(ibond)
    :math:`\Delta{ij}`. Anisotropy parameter

Computational parameters
------------------------

E(4)
    Four lowest eigenvalues
x(idim, nvec)
    `nvec` eigenvectors with lowest eigenvalues
iv
    Specifies initial random vector with `iv`\ th component set to 1.
wk(idim, 2)
    working area necessary to calculate eigenvectors in lncv. Needs `4` for inv. 
itr
    Iteration steps for convergence in Lanczos method.
Hexpec
    :math:`<x|H|x>`. Eigenvalue from obtained vector `x`


Configuration generator
-----------------------

sz szdy sztn
    Generate two lists (list1 and list2) to store configurations and locate
    positons in matrix.


Matrix storage
--------------

small.for
    elemnt(idim, idim), which stores the full matrix
medium.for
    elemnt(idim, ic), which stores only nonzero matrix elements
large.for
    No matrix element stored, with only matrix-vector multiplication


Eigenvectors
------------

lnc
    Able to obtain up to four lowest eigenvectors with decreasing precison for higher
    states.
inv
    Able to obtain any specific eigenvector with higher precison. Needs more
    working space and CPU time. One eigenvector at a time.

Precision check
---------------

check1 check2 check3
    Precision check for obtained eigenvector and corresponding eigenvalue
