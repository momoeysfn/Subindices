IndexStablityTHM:=function(m,n)
local validorders,p,q,r,s,groups,validsubgroups,validsubgroupsId,psgindexstable,group,allsubgroups,flag,subgroup;
validorders:=[];
for p in [0..4] do
for q in [0..2] do
for r in [0..1] do
for s in [0..1] do
Add(validorders,2^p*3^q*5^r*7^s);
od; od; od; od;
validorders:=Set(Filtered(validorders,x-> x in [m..n]));
groups:=Filtered(AllSmallGroups(validorders),g->IsAbelian(g)=false);
validsubgroups:=[SymmetricGroup(3),AbelianGroup([7]),AbelianGroup([2,2,2,2]),AbelianGroup([2,2,2]),AbelianGroup([3,3]),QuaternionGroup(8),DihedralGroup(8),AbelianGroup([4,2]),AbelianGroup([7])];
validsubgroupsId:=[];
psgindexstable:=[]; # Groups that all their proper subgroups are index stable.
for group in validsubgroups do
	Add(validsubgroupsId,IdGroup(group));
od;
groups:=Filtered(groups,G->Order(Center(G))<6 or IdGroup(Center(G)) in validsubgroupsId); # Exclude groups with non index stable centers.
for group in groups do
	allsubgroups:=AllSubgroups(group);
	flag:=1;
	for subgroup in allsubgroups do
        if Order(subgroup)>=6 and not IdGroup(subgroup) in validsubgroupsId and subgroup<>group then
            # Print(StructureDescription(group)," , ",StructureDescription(subgroup)," , ",Order(subgroup),"\n"); 
            flag:=0;
            break;
        fi;
	od;
	if flag=1 then Add(psgindexstable,[group,StructureDescription(group),IdGroup(group)]); fi;
od;
return psgindexstable;
end;
