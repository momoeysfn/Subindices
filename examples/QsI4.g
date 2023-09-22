Qs_I_4_a:=function(n)
local A,groups,subsets,ridpmA,lidpmA,group;
groups:=AllSmallGroups([10..n]);
for group in groups do
	subsets:=Combinations(Elements(group),Int(Ceil(Sqrt(Order(group)+0.0))));
	for A in subsets do 
		ridpmA:=RidPM(group,A);
        lidpmA:=LidPM(group,A);
        if Length(Set(Union(ridpmA,lidpmA)))=1 and Union(ridpmA,lidpmA)[1]=1 then
            Print( [group,StructureDescription(group),A,ridpmA,lidpmA]); break;
        fi;
	od;
	od;
return [];
end;
#[ Group( <identity> of ... ), "1", [ <identity> of ... ], [ 1, 1 ], [ 1, 1 ] ]
# G=C10 , A={0,1,2,3} , Id(G,A)=1

Qs_I_4_b:=function(n)
local A,groups,subsets,ridpmA,lidpmA,group;
groups:=AllSmallGroups([2..n]);
for group in groups do
	subsets:=Combinations(Elements(group),Int(Sqrt(Order(group)+0.0)));
	for A in subsets do 
		ridpmA:=RidPM(group,A);
        lidpmA:=LidPM(group,A);
        if Length(Set(Union(ridpmA,lidpmA)))=1 and Union(ridpmA,lidpmA)[1]=1 then
            Print( [group,StructureDescription(group),A,ridpmA,lidpmA]); break;
        fi;
	od;
	od;
return [];
end;

# gap> Qs_I_4_b(23);
# [ ] 
