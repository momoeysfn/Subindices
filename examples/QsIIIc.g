Qs_III_c:=function(n)
local flag,elements,identity,subset,knownsubsets,g,rpm,lpm,validsubsets,i,A,k,validgroups,group,inv;
flag:=0;
validgroups:=Filtered(AllSmallGroups([1..n]),group->IsAbelian(group)=false);
for group in validgroups do
	validsubsets:=[];
	elements:=Elements(group);
	identity:=elements[1];
	elements:=Difference(elements,[identity]);
	for k in [1..Int(Order(group)/3)-1] do
		for subset in Combinations(elements,k) do
			Add(subset,identity);
			Add(validsubsets,Set(subset));
		od;
	od;
	knownsubsets:=[];
	for A in validsubsets do 
		if not A in knownsubsets then
            inv:=Inv(group, A);
			for g in inv do
				Add(knownsubsets,Mul(group,[g],A));
				Add(knownsubsets,Mul(group,A,[g]));
			od;
			Add(knownsubsets,inv);
			if IsSubgroup(group,AsGroup(RD(group,A)))=false and IsSubgroup(group,AsGroup(LD(group,A)))=false and IsEqualSet(A,Inv(group,A))=false then
				rpm:=RidPM(group,A);
				lpm:=LidPM(group,A);
				if IsSet([rpm[1],rpm[2],lpm[1],lpm[2]]) then flag:=1; return [group,A]; fi;
			fi;
		fi;
	od;
od;
if flag=0 then
    return [];
fi;
end;

# gap> Qs_III_c(27);
# [ ]
