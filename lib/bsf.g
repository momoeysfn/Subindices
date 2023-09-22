RBSF:=function(group, subsetA)
local g0,branch,rsf,BR,final,remain,g,LCA,lc_current,lc_previous;
LCA:=LC(group, subsetA);
final:=[];
remain:=[];
for g0 in Elements(group) do
	if LCA=[] then Add(final,[[g0],[]]); 
	else 
        BR:=[g0];
        lc_previous:=Mul(group, LCA,[g0]);
        for g in lc_previous do
            lc_current:=Intersection(lc_previous,Mul(group, LCA,[g]));
            if lc_current=[] then 
                Add(final,[Union(BR,[g]),lc_current]);
            else 
                Add(remain,[Union(BR,[g]),lc_current]);
            fi;
        od;
        final:=Set(final);
        remain:=Set(remain);
    fi;
od;
while remain<>[] do
	for branch in remain do
		BR:=branch[1];
        lc_previous:=branch[2];
        for g in lc_previous do
            lc_current:=Intersection(lc_previous,Mul(group, LCA,[g]));
            if lc_current=[] then 
                Add(final,[Union(BR,[g]),lc_current]);
            else 
                Add(remain,[Union(BR,[g]),lc_current]);
            fi;
        od;
        final:=Set(final);
		remain:=Difference(remain,[branch]);
	od;
od;
rsf:=[];
for branch in final do
	Add(rsf,branch[1]);
od;
return Set(rsf);
end;