Qs_VIII_b:= function(n)
local O,groups;
O:=[];
groups:=AllSmallGroups([1..n]);
for G in groups do
    if IndslMinus(G)=Num(G) and IndPlus(G)<>Num(G) then return [StructureDescription(G),IndslMinus(G),IndMinus(G),IndslPlus(G),IndPlus(G),Num(G)]; fi;
od;
return [];
end;
# gap> QsVIIIb(10);
# [ "C8", [ 1, 2, 3, 4, 8 ], [ 1, 2, 4, 8 ], [ 1, 2, 4, 8 ], [ 1, 2, 4, 8 ], [ 1, 2, 3, 4, 8 ] ]