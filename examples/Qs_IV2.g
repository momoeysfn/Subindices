Qs_IV2_p1:=function(n)
local A,groups,ridminus,lidminus,group,a;
groups:=AllSmallGroups([1..n]);
for group in groups do
    for a in Elements(group) do
		A:=[Identity(group),a];
		ridminus:=RidMinus(group,A);
		lidminus:=LidMinus(group,A);
		if ridminus<>lidminus then return [group,StructureDescription(group),A,ridminus,lidminus]; fi;
	od;
od;
return [];
end;

# gap> Qs_IV2_p1(23);
# [ ]

Qs_IV2_p2_minus:=function(n)
local A,groups,ridminus,lidminus,group,subsets;
groups:=AllSmallGroups([1..n]);
for group in groups do
    subsets:=Difference(Combinations(Elements(group)),[[]]);
    for A in subsets do
        if LD(group, A)=RD(group, A) then
            ridminus:=RidMinus(group,A);
            lidminus:=LidMinus(group,A);
            if ridminus<>lidminus then return [group,StructureDescription(group),A,ridminus,lidminus]; fi;
        fi;
	od;
od;
return [];
end;

# gap> Qs_IV2_p2_minus(18);
# [ ]

Qs_IV2_p2_plus:=function(n)
local A,groups,ridplus,lidplus,group,subsets;
groups:=AllSmallGroups([1..n]);
for group in groups do
    subsets:=Difference(Combinations(Elements(group)),[[]]);
    for A in subsets do
        if LD(group, A)=RD(group, A) then
            ridplus:=RidPlus(group,A);
            lidplus:=LidPlus(group,A);
            if ridplus<>lidplus then return [group,StructureDescription(group),A,ridplus,lidplus]; fi;
        fi;
	od;
od;
return [];
end;

# gap> Qs_IV2_p2_plus(18);
# [ ]
