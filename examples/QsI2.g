Qs_I_2:=function(n)
local elements,A,groups,subsets,k,ridpmA,lidpmA,group;
groups:=AllSmallGroups([3..n]);
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
        if Length(Set(ridpmA))=1 then
            lidpmA:=LidPM(group,A);
            if IsSubset([1,2],Union(ridpmA,lidpmA)) then
                return [group,StructureDescription(group),A,ridpmA,lidpmA];
            fi;
        fi;
	od;
	od;
return [];
end;
# [ SymmetricGroup( [ 1 .. 3 ] ), "S3", [ (), (1,2,3) ], [ 2, 2 ], [ 2, 2 ] ]

# Order(G) >= 10
# G = D10, A = {1, a, a^2}, Id(G,A) = 2 .