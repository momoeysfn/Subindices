RSF1:= function(group, subsetA)
local B,rsf,lowerbound,upperbound,LCA,validsubsets,k,C;
LCA:=LC(group, subsetA); 
lowerbound:=Int(Order(group)/Length(LD(group, subsetA)))-1;
upperbound:=Minimum([Int(Order(group)/Length(subsetA))+1,Length(LCA)]);
validsubsets:=[];
for k in [lowerbound..upperbound] do
	for C in Combinations(LCA,k) do
		Add(C,Identity(group));
		Add(validsubsets,C);
		od;
	od;	
rsf:=[];
for B in validsubsets do
	if IsEqualSet(Elements(group),Mul(group, LD(group, subsetA), B)) and Intersection(LD(group, subsetA),RD(group, B))=[Identity(group)] then 
		Add(rsf,Set(B)); fi;
	od;
return rsf;
end;

LSF1:= function(group, subsetA)
local B,lsf,lowerbound,upperbound,RCA,validsubsets,k,C;
RCA:=RC(group, subsetA); 
lowerbound:=Int(Order(group)/Length(RD(group, subsetA)))-1;
upperbound:=Minimum([Int(Order(group)/Length(subsetA))+1,Length(RCA)]);
validsubsets:=[];
for k in [lowerbound..upperbound] do
	for C in Combinations(RCA,k) do
		Add(C,Identity(group));
		Add(validsubsets,C);
		od;
	od;	
lsf:=[];
for B in validsubsets do
	if IsEqualSet(Elements(group),Mul(group, B,RD(group, subsetA))) and Intersection(LD(group, B),RD(group, subsetA))=[Identity(group)] then 
		Add(lsf,Set(B)); fi;
	od;
return lsf;
end;

RSF:= function(group, subsetA)
local g,rsf1,rsf ,B;
rsf1:=RSF1(group, subsetA);
rsf:=[];
for B in rsf1 do
	for g in Elements(group) do
		Add(rsf,Mul(group, B,[g]));
	od;
od;
return Set(rsf);
end;

LSF:= function(group, subsetA)
local g,lsf1,lsf ,B;
lsf1:=LSF1(group, subsetA);
lsf:=[];
for B in lsf1 do
	for g in Elements(group) do
		Add(lsf,Mul(group, [g] ,B));
	od;
od;
return Set(lsf);
end;