RBSFRandom:=function(group, subsetA)
local g0,branch,rsf,BR,final,remain,g,LCA,lc_current,lc_previous;
LCA:=LC(group, subsetA);
final:=[];
remain:=[];
g0:=Random(Elements(group));
if LCA=[] then Add(final,[[g0],[]]); 
else 
    BR:=[g0];
    lc_previous:=Mul(group, LCA,[g0]);
    g:=Random(lc_previous);
    lc_current:=Intersection(lc_previous,Mul(group, LCA,[g]));
    if lc_current=[] then 
        Add(final,[Union(BR,[g]),lc_current]);
    else 
        Add(remain,[Union(BR,[g]),lc_current]);
    fi;
    final:=Set(final);
    remain:=Set(remain);
fi;
while remain<>[] do
	for branch in remain do
		BR:=branch[1];
        lc_previous:=branch[2];
        g:=Random(lc_previous);
        lc_current:=Intersection(lc_previous,Mul(group, LCA,[g]));
        if lc_current=[] then 
            Add(final,[Union(BR,[g]),lc_current]);
        else 
            Add(remain,[Union(BR,[g]),lc_current]);
        fi;
        final:=Set(final);
        remain:=Difference(remain,[branch]);
	od;
od;
rsf:=final[1][1];
return Set(rsf);
end;

# Noted Counterexamples for Theorem 3.1
# gap> G:=SmallGroup(56,11);;
# gap> Print(StructureDescription(G)); 
# "(C2 x C2 x C2) : C7"
# gap> sg:=Elements(G);;
# gap> A:=[sg[1],sg[2],sg[3],sg[4],sg[5],sg[31]];
# [ <identity> of ..., f1, f2, f3, f4, f1^4*f3 ]
# gap> RBSFRandom(G,A);
# [ <identity> of ..., f1*f2, f1^3*f4, f1^5, f1^6*f2*f3*f4 ] 
# gap> RBSFRandom(G,A);
# [ f1, f2, f1^3, f1^2*f3 ] 


# gap> G:=SmallGroup(80,49);;
# gap> Print(StructureDescription(G)); 
# "(C2 x C2 x C2 x C2) : C5"
# gap> sg:=Elements(G);
# gap> A:=[sg[1],sg[2],sg[3],sg[4],sg[5],sg[6]];
# [ <identity> of ..., f1, f2, f3, f4, f5 ]
# gap> rd:=RBSFRandom(G,A);; Print(rd," ",Length(rd));
# [ <identity> of ..., f1*f3, f1*f4*f5, f3*f4*f5, f1^3*f2, f1^4*f2*f4, f1^3*f2*f4*f5, f1^2*f2*f3*f4*f5 ] 8
# gap> rd:=RBSFRandom(G,A);; Print(rd," ",Length(rd));
# [ f3, f1*f5, f1^3, f1^2*f3, f2*f4*f5, f1^3*f4*f5, f1^2*f3*f4*f5, f1^4*f2*f3*f4, f1^4*f3*f4*f5 ] 9
