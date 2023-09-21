#Table
KIndexStability_CSV:=function(m,n)
local groups,k,group;
groups:=AllSmallGroups([m..n]);
for group in groups do
	Print(StructureDescription(group)," ,");
	for k in [2..Int(Order(group)/2)] do
		if k<>Int(Order(group)/2) then
			Print(IskIndexStable(group, k)," ,");
		else 
			Print(IskIndexStable(group, k),"\n");
		fi;
	od;
od;
end;	