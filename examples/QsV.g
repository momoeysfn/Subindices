Qs_V_p1:=function(n)
local elements,groups,A,rsfA,lsfA,group;
groups:=AllSmallGroups([1..n]);
for group in groups do
	elements:=Elements(group);
	for A in Difference(Combinations(elements),[[]]) do 
        if IsEqualSet(A,Inv(group, A)) then
                rsfA:=RSF(group, A);
                lsfA:=LSF(group, A);
                if not IsEqualSet(rsfA,lsfA) then
                    return [group,StructureDescription(group),A, Inv(group, A),rsfA,lsfA];
                fi;
        fi;
	od;
od;
return [];
end;

Qs_V_p2:=function(n)
local elements,groups,A,rsfA,lsfA,group;
groups:=AllSmallGroups([1..n]);
for group in groups do
	elements:=Elements(group);
	for A in Difference(Combinations(elements),[[]]) do 
		 	 rsfA:=RSF(group, A);
		 	 lsfA:=LSF(group, A);
			 if IsEqualSet(rsfA,lsfA) and not IsEqualSet(A,Inv(group, A)) then
			 	return [group,StructureDescription(group),A,Inv(group, A),rsfA,lsfA];
			 fi;
	od;
od;
return [];
end;