Qs_IV_a_1:=function(n)
local elements,ksubsets,subset,groups,subsets,A,k,ridminusB,ridminusA,B,group;
groups:=AllSmallGroups([1..n]);
for group in groups do
	subsets:=[];
	elements:=Elements(group);
	for k in [1..Order(group)] do
		ksubsets:=Combinations(elements,k);
		for subset in ksubsets do
			Add(subsets,Set(subset));
		od;
	od;
	for A in subsets do 
		for B in Filtered(Combinations(elements),B->IsSubset(B,A)) do
		 	ridminusB:=RidMinus(group,B);
		 	ridminusA:=RidMinus(group,A);
			if ridminusB > ridminusA then
			    return [group,StructureDescription(group),B,A,ridminusB,ridminusA];
			fi;
		od;
	od;
od;
return [];
end;

Qs_IV_a_2:=function(n)
local elements,ksubsets,subset,groups,subsets,A,k,ridplusB,ridminusA,B,group;
groups:=AllSmallGroups([1..n]);
for group in groups do
	subsets:=[];
	elements:=Elements(group);
	for k in [1..Order(group)] do
		ksubsets:=Combinations(elements,k);
		for subset in ksubsets do
			Add(subsets,Set(subset));
		od;
	od;
	for A in subsets do 
		for B in Filtered(Combinations(elements),B->IsSubset(B,A)) do
		 	ridplusB:=RidPlus(group,B);
		 	ridminusA:=RidMinus(group,A);
			if ridplusB > ridminusA then
			    return [group,StructureDescription(group),B,A,ridplusB,ridminusA];
			fi;
		od;
	od;
od;
return [];
end;
