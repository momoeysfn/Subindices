Qs_I_1:=function(n)
local sind,elements,A,groups,subsets,k,ridpmA,libpmA,group;
groups:=AllSmallGroups([1..n]);
for group in groups do
	subsets:=[];
	elements:=Elements(group);
	for k in [1..Order(group)] do
	if k+0.0 > Sqrt(Order(group)+0.0) then #
		for A in Combinations(elements,k) do
			Add(subsets,Set(A));
		od;
	fi;
	od;
	for A in subsets do 
		 ridpmA:=RidPM(group,A);
		 libpmA:=LidPM(group,A);
		 sind:=[ridpmA[1],ridpmA[2],libpmA[1],libpmA[2]];
		 if Length(Set(sind))=1 then
		 	if Set(sind)[1]<>1 then return [group,StructureDescription(group),A,sind]; fi;
		 fi;
	od;
	od;
return [];
end;
#[ SymmetricGroup( [ 1 .. 3 ] ), "S3", [ (), (2,3), (1,2) ], [ 2, 2, 2, 2 ] ]

# Order(G) >= 10 and k > Sqrt(Order(group)) and k < Int(Order(group)/2) 
# G = D10, A = {1, a, b, a^4*b}, Id(G,A)= 2 

# k > Sqrt(Order(group)) and k < Int(Order(group)/3)
# G = C15, A = { 0, 1, 2, 3 }, Id(G,A)=2




