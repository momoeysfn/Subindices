Qs_I_3:=function(n)
local elements,A,groups,subsets,k,ridpmA,lidpmA,group;
groups:=Filtered(AllSmallGroups([3..n]),G->IsAbelian(G));
for group in groups do
	subsets:=[];
	elements:=Elements(group);
	for k in [1..Int(Order(group)/3)] do
		for A in Combinations(elements,k) do
			Add(subsets,Set(A));
		od;
	od;
	for A in subsets do 
		ridpmA:=RidPM(group,A);
        lidpmA:=LidPM(group,A);
        if Length(Set(Union(ridpmA,lidpmA)))=1 and Union(ridpmA,lidpmA)[1] in [1,2] then
            return [group,StructureDescription(group),A,ridpmA,lidpmA]; 
        fi;
	od;
	od;
return [];
end;
# G = C6, A = {0, 2}, Id(G,A) = 2 

#Order(G)>=10
# G = C10, A = {0, 1, 3}, Id(G,A) = 2 