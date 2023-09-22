Qs_III_i:=function(n)
local indgroup,group,elements,groups,subsets,A,k,ridpm,lidpm,indsubgroup,subgroups;
groups:=AllSmallGroups([10..n]);
for group in groups do
	subsets:=[];
	elements:=Elements(group);
	for k in [1..Int(Order(group)/2)] do
		for A in Combinations(elements,k) do
			Add(subsets,Set(A));
		od;
	od;
	for A in subsets do 
		ridpm:=RidPM(group,A);
		lidpm:=LidPM(group,A);
		indgroup:=[ridpm[1],ridpm[2],lidpm[1],lidpm[2]];
		if Length(Set(indgroup))<>1 then 
			subgroups:=Filtered(AllSubgroups(group),m->IsSubset(Elements(m),A));
			for H in subgroups do
				ridpm:=RidPM(H,A);
				lidpm:=LidPM(H,A);
				indsubgroup:=[ridpm[1],ridpm[2],lidpm[1],lidpm[2]];
				if Length(Set(indsubgroup))=1 then
					return [StructureDescription(group),H,StructureDescription(H),A,indgroup,indsubgroup];
				fi;
			od;
		fi;
	od;
od;
return [];
end;
# gap> Qs_III_i(18);
# [ ]
