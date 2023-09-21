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