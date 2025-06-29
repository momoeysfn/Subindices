# Examples for Theorem 3.1 - Step 5 - Case 2

**Note:** `RBSFRandom(G, A)` returns a random right sub-factor of the group `G` related to `A`.

### `(C2 x C2 x C2) : C7`

```gap
gap> G := SmallGroup(56, 11);;
gap> Print(StructureDescription(G)); 
"(C2 x C2 x C2) : C7"
gap> sg := Elements(G);;
gap> A := [sg[1], sg[2], sg[3], sg[4], sg[5], sg[31]];
[ <identity> of ..., f1, f2, f3, f4, f1^4*f3 ]
gap> RBSFRandom(G, A);
[ <identity> of ..., f1*f2, f1^3*f4, f1^5, f1^6*f2*f3*f4 ] 
gap> RBSFRandom(G, A);
[ f1, f2, f1^3, f1^2*f3 ] 
```

### `(C2 x C2 x C2 x C2) : C5`
```gap
gap> G:=SmallGroup(80,49);;
gap> Print(StructureDescription(G)); 
"(C2 x C2 x C2 x C2) : C5"
gap> sg:=Elements(G);
gap> e:=One(G);;t:=G.1;;x:=G.2;;y:=G.3;;z:=G.4;;w:=G.5;;
gap> A:=[e,x,y,z,w,t];;
gap> rd:=RBSFRandom(G,A);; Print(rd," ",Length(rd));
[ <identity> of ..., f1*f3, f1*f4*f5, f3*f4*f5, f1^3*f2, f1^4*f2*f4, f1^3*f2*f4*f5, f1^2*f2*f3*f4*f5 ] 8
gap> rd:=RBSFRandom(G,A);; Print(rd," ",Length(rd));
[ f3, f1*f5, f1^3, f1^2*f3, f2*f4*f5, f1^3*f4*f5, f1^2*f3*f4*f5, f1^4*f2*f3*f4, f1^4*f3*f4*f5 ] 9
gap> B:=[e,y*z*t,x*z*w*t,y*z*w,x*y*z*w*t^3,x*y*t^4,z*t^3,x*t^2];;
gap> Size(B);
8
gap> M:=List(Cartesian(A, B), pair -> pair[1] * pair [2]);;
gap> Size(M)=Size(A)*Size(B);
true
gap> U:=Difference(G,M);;
gap> ForAll(U,u->not IsEmpty(Intersection(List(A,a->a*u),M)));
true
gap> B:=[y,x*t,t^3,y*w*t^2,x*z*w,x*y*w*t^3,z*t^2,y*w*t^4,x*z*w*t^4];;
gap> Size(B);
9
gap> M:=List(Cartesian(A, B), pair -> pair[1] * pair [2]);;
gap> Size(M)=Size(A)*Size(B);
true
gap> U:=Difference(G,M);;
gap> ForAll(U,u->not IsEmpty(Intersection(List(A,a->a*u),M)));
true
gap>
```
