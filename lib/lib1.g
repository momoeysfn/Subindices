Mul:= function(group, subsetA, subsetB)
local product,a,b;
product:=[];
for a in subsetA do
    for b in subsetB do
        Add(product, a*b);
    od;
od;
return Set(product);
end;

Inv:= function(group, subset)
local inv,element;
inv:=[];
for element in subset do
    Add(inv, element^-1);
od;
return Set(inv);
end;

RD:= function(group, subset)
return Mul(group, subset,Inv(group, subset));
end;
LD:= function(group, subset)
return Mul(group, Inv(group, subset),subset);
end;

RC:= function(group, subset)
return Difference(Elements(group),RD(group, subset));
end;
LC:= function(group, subset)
return Difference(Elements(group),LD(group, subset));
end;

IsDirect:= function(group, subsetA, subsetB)
return Intersection(LD(group, subsetA),RD(group, subsetB))=[Identity(group)];
end;

IsFactorization:= function(group, subsetA, subsetB)
return IsEqualSet(Elements(group),Mul(group, subsetA,subsetB)) and Intersection(LD(group, subsetA),RD(group, subsetB))=[Identity(group)];
end;

RF:= function(group, subsetA)
local B,rf;
rf:=[];
for B in Difference(Combinations(Elements(group),[[]])) do
	if IsFactorization(group, subsetA, B) then 
		Add(rf,Set(B)); fi;
	od;
return rf;
end;

LF:= function(group, subsetA)
local B,lf;
lf:=[];
for B in Difference(Combinations(Elements(group),[[]])) do
	if IsFactorization(group, B, subsetA) then 
		Add(lf,Set(B)); fi;
	od;
return lf;
end;
