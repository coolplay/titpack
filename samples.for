c>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
c        ACKNOWLEDGE THE USE OF THIS PACKAGE
c         WHEN YOU PUBLISH YOUR RESULTS !!!
c>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
c
c************* Sample main program #1 ***************
c  1d Heisenberg antiferromagnet with 16 spins
c   Eigenvalues and an eigenvector / lnc1, lncv1
c    Precision check and correlation functions
c***********************************************
      parameter (n=16,idim=12870,ibond=n)
      implicit real*8 (a-h,o-z)
      dimension E(4)
      dimension list1(idim),list2(2,0:2**15)
      dimension bondwt(ibond),ipair(2*ibond),zrtio(ibond)
      dimension npair(2)
      dimension wk(idim,2)
      dimension x(idim)
c
      data bondwt/ibond*-1.0d0/
      data zrtio/ibond*1.0d0/
      data ipair/1,2, 2,3,  3,4,  4,5,  5,6,  6,7,  7,8, 8,9,
     &     9,10, 10,11, 11,12, 12,13, 13,14, 14,15, 15,16, 16,1/
      nvec=1
      iv=idim/3
      call sz(n,idim,0.0d0,list1,list2)
c- You may alternatively use szdy or sztn for faster processing -
c      call szdy(n,idim,0.0d0,list1,list2)
c  or
c      call sztn(n,idim,0.0d0,list1,list2)
c------------------------------------------------------------
c*** Eigenvalues
      call lnc1(n,idim,ipair,bondwt,zrtio,ibond,
     &                 nvec,iv,E,itr,wk,idim,list1,list2)
      print 100,e,itr
 100  format(/' [Eigenvalues]  '/2x,4f14.8
     &       /' [Iteration number]'/i8)
c
c*** Ground-state eigenvector
      call lncv1(n,idim,ipair,bondwt,zrtio,ibond,
     &            nvec,iv,x,itr,wk,idim,list1,list2)
c- You may alternatively use inv1 / Note: dimension wk(idim,4) -
c      call inv1(n,idim,ipair,bondwt,zrtio,ibond,
c     &          E(1),iv,x,wk,idim,list1,list2)
c---------------------------------------------------------------
      print *,'[Eigenvector components (selected)]'
      print 120,(x(j),j=13,idim,idim/20)
 120  format(4d18.9)
c
c*** Precision check and correlation functions
      call check1(n,idim,ipair,bondwt,zrtio,ibond,
     &            x,wk,Hexpec,list1,list2)
      npair(1)=1
      npair(2)=2
      call xcorr(n,idim,npair,1,x,sxx,list1,list2)
      call zcorr(n,idim,npair,1,x,szz,list1)
      print 130,sxx,szz
 130  format(/' [Nearest neighbor correlation functions]'/
     &       '    sxx :',d18.10,',    szz :',d18.10)
      end
c************ Sample main program #2 **************
c  1d Heisenberg antiferromagnet with 16 spins
c           Eigenvector by inv1
c  Precision check and correlation functions
c*********************************************
      parameter (n=16,idim=12870,ibond=n)
      parameter (nbond=1)
      implicit real*8 (a-h,o-z)
      dimension E(4)
      dimension list1(idim),list2(2,0:2**15)
      dimension bondwt(ibond),ipair(2*ibond),zrtio(ibond)
      dimension npair(2)
      dimension wk(idim,4)
      dimension x(idim),sxx(nbond),szz(nbond)
c
      data bondwt/ibond*-1.0d0/
      data zrtio/ibond*1.0d0/
      data ipair/1,2, 2,3,  3,4,  4,5,  5,6,  6,7,  7,8, 8,9,
     &     9,10, 10,11, 11,12, 12,13, 13,14, 14,15, 15,16, 16,1/
      nvec=1
      iv=idim/3
      call sz(n,idim,0.0d0,list1,list2)
c- You may alternatively use szdy or sztn for faster processing -
c      call szdy(n,idim,0.0d0,list1,list2)
c  or
c      call sztn(n,idim,0.0d0,list1,list2)
c------------------------------------------------------------
c
c*** Eigenvalues
      call lnc1(n,idim,ipair,bondwt,zrtio,ibond,
     &                 nvec,iv,E,itr,wk,idim,list1,list2)
      print 100,e,itr
 100  format(/' [Eigenvalues]  '/2x,4f14.8
     &       /' [Iteration number]'/i8)
c
c*** Ground-state eigenvector
      call inv1(n,idim,ipair,bondwt,zrtio,ibond,
     &          E(1),iv,x,wk,idim,list1,list2)
      print *,'[Eigenvector components (selected)]'
      print 120,(x(j),j=13,idim,idim/20)
 120  format(4d18.9)
c
c*** Precision check and correlation functions
      call check1(n,idim,ipair,bondwt,zrtio,ibond,
     &            x,wk,Hexpec,list1,list2)
      npair(1)=1
      npair(2)=2
      call xcorr(n,idim,npair,1,x,sxx,list1,list2)
      call zcorr(n,idim,npair,nbond,x,szz,list1)
      print 130,sxx,szz
 130  format(/' [Nearest neighbor correlation functions]'/
     &       '    sxx :',d18.10,',    szz :',d18.10)
      end 
c************ Sample main program #3 **************
c  1d Heisenberg antiferromagnet with 16 spins
c    Eigenvectors of excited states by lncv1
c*********************************************
      parameter (n=16,idim=12870,ibond=n)
      parameter (nvec=3,nbond=1)
      implicit real*8 (a-h,o-z)
      dimension E(4)
      dimension list1(idim),list2(2,0:2**15)
      dimension bondwt(ibond),ipair(2*ibond),zrtio(ibond)
      dimension wk(idim,2)
      dimension x(idim,nvec)
c
      data bondwt/ibond*-1.0d0/
      data zrtio/ibond*1.0d0/
      data ipair/1,2, 2,3,  3,4,  4,5,  5,6,  6,7,  7,8, 8,9,
     &     9,10, 10,11, 11,12, 12,13, 13,14, 14,15, 15,16, 16,1/
      iv=idim/3
      call sz(n,idim,0.0d0,list1,list2)
c- You may alternatively use szdy or sztn for faster processing -
c      call szdy(n,idim,0.0d0,list1,list2)
c  or
c      call sztn(n,idim,0.0d0,list1,list2)
c------------------------------------------------------------
c
c*** Eigenvalues
      call lnc1(n,idim,ipair,bondwt,zrtio,ibond,
     &                 nvec,iv,E,itr,wk,idim,list1,list2)
      print 100,e,itr
 100  format(/' [Eigenvalues]  '/2x,4f14.8
     &       /' [Iteration number]'/i8)
c
c*** Eigenvectors
      call lncv1(n,idim,ipair,bondwt,zrtio,ibond,
     &            nvec,iv,x,itr,wk,idim,list1,list2)
      print *,'[Eigenvector components (selected)]'
      print 120,(x(j,nvec),j=13,idim,idim/20)
 120  format(4d18.9)
c
c*** Precision check and correlation functions
      call check1(n,idim,ipair,bondwt,zrtio,ibond,
     &            x(1,nvec),wk,Hexpec,list1,list2)
      end
c************ Sample main program #4 **************
c  1d Heisenberg antiferromagnet with 16 spins
c  Eigenvector of an excited state by inv1
c*********************************************
      parameter (n=16,idim=12870,ibond=n)
      parameter (nbond=1)
      implicit real*8 (a-h,o-z)
      dimension E(4)
      dimension list1(idim),list2(2,0:2**15)
      dimension bondwt(ibond),ipair(2*ibond),zrtio(ibond)
      dimension wk(idim,4)
      dimension x(idim)
c
      data bondwt/ibond*-1.0d0/
      data zrtio/ibond*1.0d0/
      data ipair/1,2, 2,3,  3,4,  4,5,  5,6,  6,7,  7,8, 8,9,
     &     9,10, 10,11, 11,12, 12,13, 13,14, 14,15, 15,16, 16,1/
c
      nvec=0
      iv=idim/3
      call sz(n,idim,0.0d0,list1,list2)
c
c*** Eigenvalues
      call lnc1(n,idim,ipair,bondwt,zrtio,ibond,
     &                 nvec,iv,E,itr,wk,idim,list1,list2)
      print 100,e,itr
 100  format(/' [Eigenvalues]  '/2x,4f14.8
     &       /' [Iteration number]'/i8)
c
c*** Eigenvectors
      call inv1(n,idim,ipair,bondwt,zrtio,ibond,
     &          E(3),iv,x,wk,idim,list1,list2)
      print *,'[Eigenvector components (selected)]'
      print 120,(x(j),j=13,idim,idim/20)
 120  format(4d18.9)
c
c*** Precision check and correlation functions
      call check1(n,idim,ipair,bondwt,zrtio,ibond,
     &            x,wk,Hexpec,list1,list2)
      end
c************ Sample main program #5 **************
c  1d Heisenberg antiferromagnet with 16 spins
c Degeneracy check by various initial vectors
c*********************************************
      parameter (n=16,idim=12870,ibond=n)
      parameter (nbond=1)
      implicit real*8 (a-h,o-z)
      dimension E(4)
      dimension list1(idim),list2(2,0:2**15)
      dimension bondwt(ibond),ipair(2*ibond),zrtio(ibond)
      dimension wk(idim,2)
      dimension x(idim),v(idim,2),norm(2)
c
      data bondwt/ibond*-1.0d0/
      data zrtio/ibond*1.0d0/
      data ipair/1,2, 2,3,  3,4,  4,5,  5,6,  6,7,  7,8, 8,9,
     &     9,10, 10,11, 11,12, 12,13, 13,14, 14,15, 15,16, 16,1/
c
      nvec=1
      call sz(n,idim,0.0d0,list1,list2)
c- You may alternatively use szdy or sztn for faster processing -
c      call szdy(n,idim,0.0d0,list1,list2)
c  or
c      call sztn(n,idim,0.0d0,list1,list2)
c------------------------------------------------------------
c
      k=0
c*** Two different initial conditions
      do 10 iv=21,idim,idim/2
        k=k+1
        call lnc1(n,idim,ipair,bondwt,zrtio,ibond,
     &                   nvec,iv,E,itr,wk,idim,list1,list2)
        print 100,k,e
 100    format(/' #',i2,' [Eigenvalues]  '/2x,4f14.8)
        call lncv1(n,idim,ipair,bondwt,zrtio,ibond,
     &              nvec,iv,x,itr,wk,idim,list1,list2)
        do 20 j=1,idim
 20     v(j,k)=x(j)
 10   continue
c
c*** Degeneracy check
      call orthg(idim,idim,v,norm,idgn,2)
      print 110,idgn,norm
 110  format(/' [Degeneracy] :',i4, '   Norm :',2i4)
      end
c************* Sample main program #6 *****************
c  1d Heisenberg antiferromagnet with 16 spins
c   Eigenvalues and an eigenvector/ lnc2, lncv2
c    Precision check and correlation functions
c***********************************************
c
      parameter (n=16,idim=12870,ibond=n,ic=ibond+1)
      implicit real*8 (a-h,o-z)
      dimension E(4)
      dimension elemnt(idim,ic),loc(idim,ic)
      dimension list1(idim),list2(2,0:2**15)
      dimension bondwt(ibond),ipair(2*ibond),zrtio(ibond)
      dimension npair(2)
      dimension wk(idim,2)
      dimension x(idim),sxx(1),szz(1)
c
      data bondwt/ibond*-1.0d0/
      data zrtio/ibond*1.0d0/
      data ipair/1,2, 2,3,  3,4,  4,5,  5,6,  6,7,  7,8, 8,9,
     &     9,10, 10,11, 11,12, 12,13, 13,14, 14,15, 15,16, 16,1/
      nvec=1
      iv=idim/5
c
      call sz(n,idim,0.0d0,list1,list2)
c- You may alternatively use szdy or sztn for faster processing -
c      call szdy(n,idim,0.0d0,list1,list2)
c  or
c      call sztn(n,idim,0.0d0,list1,list2)
c------------------------------------------------------------
      call elm2(n,idim,ipair,bondwt,zrtio,ibond,
     &          elemnt,loc,idim,ic,list1,list2)
      call lnc2(elemnt,loc,idim,idim,ic,nvec,iv,E,itr,wk)
      print 100,e,itr
  100 format(/' [Eigenvalues]  '/2x,4f14.8
     &       /' [Iteration number]'/i8)
      call lncv2(elemnt,loc,idim,idim,ic,nvec,iv,x,itr,wk)
c- You may alternatively use inv2 / Note: dimension wk(idim,4)-
c    call inv2(elemnt,loc,idim,idim,ic,iv,E(1),x,wk)
c---------------------------------------------------------------
      print *,'[Eigenvector components (selected)]'
      print 120,(x(j),j=13,idim,idim/20)
  120 format(4d18.9)
c
      call check2(elemnt,loc,idim,idim,ic,x,wk,Hexpec)
      npair(1)=1
      npair(2)=2
      call xcorr(n,idim,npair,1,x,sxx,list1,list2)
      call zcorr(n,idim,npair,1,x,szz,list1)
      print 130,sxx,szz
  130  format(/' [Nearest neighbor correlation functions]'/
     &       '    sxx :',d18.10,',    szz :',d18.10)
      end
c************* Sample main program #7 *****************
c  1d Heisenberg antiferromagnet with 16 spins
c             Eigenvector by inv2
c***********************************************
c
      parameter (n=16,idim=12870,ibond=n,ic=ibond+1)
      implicit real*8 (a-h,o-z)
      dimension E(4)
      dimension elemnt(idim,ic),loc(idim,ic)
      dimension list1(idim),list2(2,0:2**15)
      dimension bondwt(ibond),ipair(2*ibond),zrtio(ibond)
      dimension npair(2)
      dimension wk(idim,4)
      dimension x(idim),sxx(1),szz(1)
c
      data bondwt/ibond*-1.0d0/
      data zrtio/ibond*1.0d0/
      data ipair/1,2, 2,3,  3,4,  4,5,  5,6,  6,7,  7,8, 8,9,
     &     9,10, 10,11, 11,12, 12,13, 13,14, 14,15, 15,16, 16,1/
      nvec=1
      iv=idim/5
c
      call sz(n,idim,0.0d0,list1,list2)
c- You may alternatively use szdy or sztn for faster processing -
c      call szdy(n,idim,0.0d0,list1,list2)
c  or
c      call sztn(n,idim,0.0d0,list1,list2)
c------------------------------------------------------------
      call elm2(n,idim,ipair,bondwt,zrtio,ibond,
     &          elemnt,loc,idim,ic,list1,list2)
c*** Eigenvalues
      call lnc2(elemnt,loc,idim,idim,ic,nvec,iv,E,itr,wk)
      print 100,e,itr
  100  format(/' [Eigenvalues]  '/2x,4f14.8
     &       /' [Iteration number]'/i8)
c*** Eigenvector
      call inv2(elemnt,loc,idim,idim,ic,iv,E(1),x,wk)
      print *,'[Eigenvector components (selected)]'
      print 120,(x(j),j=13,idim,idim/20)
  120  format(4d18.9)
c*** Precision check and correlation functions
      call check2(elemnt,loc,idim,idim,ic,x,wk,Hexpec)
      npair(1)=1
      npair(2)=2
      call xcorr(n,idim,npair,1,x,sxx,list1,list2)
      call zcorr(n,idim,npair,1,x,szz,list1)
      print 130,sxx,szz
  130  format(/' [Nearest neighbor correlation functions]'/
     &       '    sxx :',d18.10,',    szz :',d18.10)
      end
c************* Sample main program #8 *****************
c  1d Heisenberg antiferromagnet with 16 spins
c    Eigenvectors of excited states by lncv2
c***********************************************
c
      parameter (n=16,idim=12870,ibond=n,ic=ibond+1)
      parameter (nvec=3)
      implicit real*8 (a-h,o-z)
      dimension E(4)
      dimension elemnt(idim,ic),loc(idim,ic)
      dimension list1(idim),list2(2,0:2**15)
      dimension bondwt(ibond),ipair(2*ibond),zrtio(ibond)
      dimension wk(idim,2)
      dimension x(idim,nvec)
c
      data bondwt/ibond*-1.0d0/
      data zrtio/ibond*1.0d0/
      data ipair/1,2, 2,3,  3,4,  4,5,  5,6,  6,7,  7,8, 8,9,
     &     9,10, 10,11, 11,12, 12,13, 13,14, 14,15, 15,16, 16,1/
      iv=idim/5
c
      call sz(n,idim,0.0d0,list1,list2)
c- You may alternatively use szdy or sztn for faster processing -
c      call szdy(n,idim,0.0d0,list1,list2)
c  or
c      call sztn(n,idim,0.0d0,list1,list2)
c------------------------------------------------------------
      call elm2(n,idim,ipair,bondwt,zrtio,ibond,
     &          elemnt,loc,idim,ic,list1,list2)
c*** Eigenvalues
      call lnc2(elemnt,loc,idim,idim,ic,nvec,iv,E,itr,wk)
      print 100,e,itr
  100  format(/' [Eigenvalues]  '/2x,4f14.8
     &       /' [Iteration number]'/i8)
c*** Eigenvectors
      call lncv2(elemnt,loc,idim,idim,ic,nvec,iv,x,itr,wk)
      print *,'[Eigenvector components (selected)]'
      print 120,(x(j,nvec),j=13,idim,idim/20)
  120  format(4d18.9)
c*** Precision check
      call check2(elemnt,loc,idim,idim,ic,x(1,nvec),wk,Hexpec)
      end
c************* Sample main program #9 *****************
c  1d Heisenberg antiferromagnet with 16 spins
c  Eigenvector of an excited state by inv2
c***********************************************
      parameter (n=16,idim=12870,ibond=n,ic=ibond+1)
      implicit real*8 (a-h,o-z)
      dimension E(4)
      dimension elemnt(idim,ic),loc(idim,ic)
      dimension list1(idim),list2(2,0:2**15)
      dimension bondwt(ibond),ipair(2*ibond),zrtio(ibond)
      dimension wk(idim,4)
      dimension x(idim)
c
      data bondwt/ibond*-1.0d0/
      data zrtio/ibond*1.0d0/
      data ipair/1,2, 2,3,  3,4,  4,5,  5,6,  6,7,  7,8, 8,9,
     &     9,10, 10,11, 11,12, 12,13, 13,14, 14,15, 15,16, 16,1/
      nvec=0
      iv=idim/5
c
      call sz(n,idim,0.0d0,list1,list2)
c- You may alternatively use szdy or sztn for faster processing -
c      call szdy(n,idim,0.0d0,list1,list2)
c  or
c      call sztn(n,idim,0.0d0,list1,list2)
c------------------------------------------------------------
      call elm2(n,idim,ipair,bondwt,zrtio,ibond,
     &          elemnt,loc,idim,ic,list1,list2)
c*** Eigenvalues
      call lnc2(elemnt,loc,idim,idim,ic,nvec,iv,E,itr,wk)
      print 100,e,itr
  100  format(/' [Eigenvalues]  '/2x,4f14.8
     &       /' [Iteration number]'/i8)
c** Eigenvector
      call inv2(elemnt,loc,idim,idim,ic,iv,E(3),x,wk)
      print *,'[Eigenvector components (selected)]'
      print 120,(x(j),j=13,idim,idim/20)
  120  format(4d18.9)
c*** Precision check
      call check2(elemnt,loc,idim,idim,ic,x,wk,Hexpec)
      end
c************* Sample main program #10 *****************
c  1d Heisenberg antiferromagnet with 15 spins
c Degeneracy check by various initial vectors
c***********************************************
c
      parameter (n=15,idim=6435,ibond=n,ic=ibond+1)
      implicit real*8 (a-h,o-z)
      dimension E(4)
      dimension elemnt(idim,ic),loc(idim,ic)
      dimension list1(idim),list2(2,0:2**15)
      dimension bondwt(ibond),ipair(2*ibond),zrtio(ibond)
      dimension wk(idim,4)
      dimension x(idim)
      dimension v(idim,3),norm(3)
c 
      data bondwt/ibond*-1.0d0/
      data zrtio/ibond*1.0d0/
      data ipair/1,2, 2,3,  3,4,  4,5,  5,6,  6,7,  7,8, 8,9,
     &     9,10, 10,11, 11,12, 12,13, 13,14, 14,15, 15,1/
      nvec=1
      iv=idim/5
c 
      call sz(n,idim,0.5d0,list1,list2)
c- You may alternatively use szdy or sztn for faster processing -
c      call szdy(n,idim,0.5d0,list1,list2)
c  or
c      call sztn(n,idim,0.5d0,list1,list2)
c------------------------------------------------------------
      call elm2(n,idim,ipair,bondwt,zrtio,ibond,
     &          elemnt,loc,idim,ic,list1,list2)
      k=0
c *** Two different initial conditions
      do 10 iv=91,idim,idim/3
        k=k+1
        call lnc2(elemnt,loc,idim,idim,ic,nvec,iv,E,itr,wk)
        print 100,k,e
  100    format(/' #',i2,' [Eigenvalues]  '/2x,4f14.8)
        call inv2(elemnt,loc,idim,idim,ic,iv,E(1),x,wk)
        print *,'[Eigenvector components (selected)]'
        print 120,(x(j),j=13,idim,idim/20)
  120    format(4d18.9)
        call check2(elemnt,loc,idim,idim,ic,x,wk,Hexpec)
        do 20 j=1,idim
  20     v(j,k)=x(j)
  10   continue
c *** Degeneracy check
      call orthg(idim,idim,v,norm,idgn,3)
      print 110,idgn
  110  format(/' [Degeneracy]'/i6)
      end
c************ Sample main program #11 *****************
c  1d Heisenberg antiferromagnet with 8 spins
c    Eigenvalues and an eigenvector by diag
c*************************************************
      parameter (n=8,idim=70,ibond=n)
      implicit real*8 (a-h,o-z)
      dimension E(4)
      dimension elemnt(idim,idim)
      dimension list1(idim),list2(2,0:2**15)
      dimension bondwt(ibond),ipair(2*ibond),zrtio(ibond)
      dimension npair(2),sxx(1),szz(1)
      dimension wk(idim,8),iwk(idim),v(idim)
c
      data bondwt/ibond*-1.0d0/
      data zrtio/ibond*1.0d0/
      data ipair/1,2, 2,3, 3,4, 4,5, 5,6, 6,7, 7,8, 8,1/
c
      call sz(n,idim,0.0d0,list1,list2)
c- You may alternatively use szdy or sztn for faster processing -
c      call szdy(n,idim,0.0d0,list1,list2)
c  or
c      call sztn(n,idim,0.0d0,list1,list2)
c------------------------------------------------------------
      call elm3(n,idim,ipair,bondwt,zrtio,ibond,
     &          elemnt,idim,list1,list2)
c
      eps=1.d-13
      nvec=1
      ne=4
      call diag(elemnt,idim,idim,E,v,ne,nvec,eps,wk,iwk)
      print 100,E
  100 format(/' [Eigenvalues]  '/2x,4f14.8)
c*** Do not forget to call elm3 again before calling check3
      call elm3(n,idim,ipair,bondwt,zrtio,ibond,
     &          elemnt,idim,list1,list2)
      call check3(elemnt,idim,idim,v,wk,Hexpec)
c
      npair(1)=1
      npair(2)=2
      call xcorr(n,idim,npair,1,v,sxx,list1,list2)
      print *,' sxx:',sxx
      call zcorr(n,idim,npair,1,v,szz,list1)
      print *,' szz:',szz
      end
