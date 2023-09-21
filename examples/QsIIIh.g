#(f) LD(2, A) = G and (A is right index stable with) Rid(A) != 2.
#Code :
Qs_III_h:=function(n)
local ridpm,A,group;
flag:=true;
for group in AllSmallGroups([1..n]) do
	for A in Difference(Combinations(Elements(group)),[[]]) do 
        ridpm:=RidPM(group, A);
		if Length(Set(ridpm))=1 then
			if  Set(ridpm)[1]<>2 and IsEqualSet(Elements(group),LDn(group, 2,A)) and not IsEqualSet(Elements(group),LD(group, A)) then return [StructureDescription(group),A,ridpm]; fi;
		fi;
	od;
	od;
return [];
end;
#Results : Qs_III_h(10) -> [ "C3 x C3", [ <identity> of ..., f1, f2 ], 3, 3 ]