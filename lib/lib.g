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
	if IsFactor(group, subsetA, B) then 
		Add(rf,Set(B)); fi;
	od;
return rf;
end;

LF:= function(group, subsetA)
local B,lf;
lf:=[];
for B in Difference(Combinations(Elements(group),[[]])) do
	if IsFactor(group, B, subsetA) then 
		Add(lf,Set(B)); fi;
	od;
return lf;
end;

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

RBSF:=function(group, subsetA)
local g0,branch,rsf,BR,final,remain,g,LCA,lc_current,lc_previous;
LCA:=LC(group, subsetA);
final:=[];
remain:=[];
for g0 in Elements(group) do
	if LCA=[] then Add(final,[[g0],[]]); 
	else 
        BR:=[g0];
        lc_previous:=Mul(group, LCA,[g0]);
        for g in lc_previous do
            lc_current:=Intersection(lc_previous,Mul(group, LCA,[g]));
            if lc_current=[] then 
                Add(final,[Union(BR,[g]),lc_current]);
            else 
                Add(remain,[Union(BR,[g]),lc_current]);
            fi;
        od;
        final:=Set(final);
        remain:=Set(remain);
    fi;
od;
while remain<>[] do
	for branch in remain do
		BR:=branch[1];
        lc_previous:=branch[2];
        for g in lc_previous do
            lc_current:=Intersection(lc_previous,Mul(group, LCA,[g]));
            if lc_current=[] then 
                Add(final,[Union(BR,[g]),lc_current]);
            else 
                Add(remain,[Union(BR,[g]),lc_current]);
            fi;
        od;
        final:=Set(final);
		remain:=Difference(remain,[branch]);
	od;
od;
rsf:=[];
for branch in final do
	Add(rsf,branch[1]);
od;
return Set(rsf);
end;

RidMinus:= function(group, subsetA)
local ridminus,lowerbound,upperbound,LCA,k,B,flag,identity,LDA,RDA;
LDA:=LD(group, subsetA);
RDA:=RD(group, subsetA);
if Length(subsetA)<=1 then ridminus:=Order(group); 
else
if Length(subsetA) > Int(Order(group)/2) then ridminus:=1;  
elif Length(subsetA) > Int(Order(group)/3) and Length(subsetA) <= Int(Order(group)/2) then 
	if IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group)) then ridminus:=1; 
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group))=false then ridminus:=2; 
	elif IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group))=false then ridminus:=1;
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group)) then ridminus:=2; fi;
else 
if IsSubgroup(group,AsGroup(LDA)) then ridminus:=Order(group)/Length(LDA); else
LCA:=LC(group, subsetA); 
lowerbound:=Int(Ceil(Order(group)/Length(LDA)+0.0));
upperbound:=Int(Order(group)/Length(subsetA));
if lowerbound=upperbound then ridminus:=upperbound; else
flag:=0;
k:=lowerbound;
identity:=Identity(group);
while flag=0 and k<=upperbound do
	for B in Combinations(LCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, LDA,B)) and Intersection(LDA,RD(group, B))=[identity] then
			ridminus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k+1;
	od;
fi; fi; fi; fi;
return ridminus;
end;	

RidPlus:= function(group, subsetA)
local ridplus,lowerbound,upperbound,LCA,k,B,flag,LDA,identity,RDA;
LDA:=LD(group, subsetA);
RDA:=RD(group, subsetA);
if Length(subsetA)<=1 then ridplus:=Order(group); 
else
if Length(subsetA) > Int(Order(group)/2) then ridplus:=1; ridplus:=1; 
elif Length(subsetA) > Int(Order(group)/3) and Length(subsetA) <= Int(Order(group)/2) then 
	if IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group)) then ridplus:=1; 
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group))=false then ridplus:=2; 
	elif IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group))=false then ridplus:=1;
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group)) then ridplus:=2; fi;
else
if IsSubgroup(group,AsGroup(LDA)) then ridplus:=Order(group)/Length(LDA); else
LCA:=LC(group, subsetA); 
lowerbound:=Int(Ceil(Order(group)/Length(LDA)+0.0));
upperbound:=Int(Order(group)/Length(subsetA));
if lowerbound=upperbound then ridplus:=upperbound; else
flag:=0;
k:=upperbound;
identity:=Identity(group);
while flag=0 and k>=lowerbound do
	for B in Combinations(LCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, LDA,B)) and Intersection(LDA,RD(group, B))=[identity] then
			ridplus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k-1;
	od;
fi; fi; fi; fi;
return ridplus;
end;

RidMP:= function(group, subsetA)
local ridminus,ridplus,lowerbound,upperbound,LCA,k,B,flag,LDA,identity,RDA;
LDA:=LD(group, subsetA);
RDA:=RD(group, subsetA);
if Length(subsetA)<=1 then ridminus:=Order(group); ridplus:=ridminus; 
else
if Length(subsetA) > Int(Order(group)/2) then ridminus:=1; ridplus:=1; 
elif Length(subsetA) > Int(Order(group)/3) and Length(subsetA) <= Int(Order(group)/2) then 
	if IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group)) then ridminus:=1; ridplus:=1; 
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group))=false then ridminus:=2; ridplus:=2;
	elif IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group))=false then ridminus:=1; ridplus:=1;
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group)) then ridminus:=2; ridplus:=2; fi;
else 
if IsSubgroup(group,AsGroup(LDA)) then ridminus:=Order(group)/Length(LDA); ridplus:=ridminus; else
LCA:=LC(group, subsetA); 
lowerbound:=Int(Ceil(Order(group)/Length(LD(group, subsetA))+0.0));
upperbound:=Int(Order(group)/Length(subsetA));
if lowerbound=upperbound then ridminus:=upperbound; else
flag:=0;
k:=lowerbound;
identity:=Identity(group);
while flag=0 and k<=upperbound do
	for B in Combinations(LCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, LDA,B)) and Intersection(LDA,RD(group, B))=[identity] then
			ridminus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k+1;
	od;
fi;
if ridminus=upperbound then ridplus:=ridminus; else
flag:=0;
k:=upperbound;
while flag=0 and k>=lowerbound do
	for B in Combinations(LCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, LDA,B)) and Intersection(LDA,RD(group, B))=[identity] then
			ridplus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k-1;
	od;
fi; fi; fi; fi;
return [ridminus,ridplus];
end;

RidPM:= function(group, subsetA)
local ridminus,ridplus,lowerbound,upperbound,LCA,k,B,flag,LDA,identity,RDA;
LDA:=LD(group, subsetA);
RDA:=RD(group, subsetA);
if Length(subsetA)<=1 then ridminus:=Order(group); ridplus:=ridminus; 
else
if Length(subsetA) > Int(Order(group)/2) then ridminus:=1; ridplus:=1; 
elif Length(subsetA) > Int(Order(group)/3) and Length(subsetA) <= Int(Order(group)/2) then 
	if IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group)) then ridminus:=1; ridplus:=1; 
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group))=false then ridminus:=2; ridplus:=2;
	elif IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group))=false then ridminus:=1; ridplus:=1;
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group)) then ridminus:=2; ridplus:=2; fi;
else 
if IsSubgroup(group,AsGroup(LDA)) then ridminus:=Order(group)/Length(LDA); ridplus:=ridminus; else
LCA:=LC(group, subsetA);
lowerbound:=Int(Ceil(Order(group)/Length(LDA)+0.0));
upperbound:=Int(Order(group)/Length(subsetA));
if lowerbound=upperbound then ridplus:=upperbound; else
flag:=0;
k:=upperbound;
identity:=Identity(group);
while flag=0 and k>=lowerbound do
	for B in Combinations(LCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, LDA,B)) and Intersection(LDA,RD(group, B))=[identity] then
			ridplus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k-1;
	od;
fi;
if ridplus=lowerbound then ridminus:=ridplus; else
flag:=0;
k:=lowerbound;
while flag=0 and k<=upperbound do
	for B in Combinations(LCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, LDA,B)) and Intersection(LDA,RD(group, B))=[identity] then
			ridminus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k+1;
	od;
fi; fi; fi; fi;
return [ridminus,ridplus];
end;

LidMinus:= function(group, subsetA)
local lidminus,lowerbound,upperbound,RCA,k,B,flag,RDA,identity,LDA;
LDA:=LD(group, subsetA);
RDA:=RD(group, subsetA);
if Length(subsetA)<=1 then lidminus:=Order(group); 
else
if Length(subsetA) > Int(Order(group)/2) then lidminus:=1; lidminus:=1; 
elif Length(subsetA) > Int(Order(group)/3) and Length(subsetA) <= Int(Order(group)/2) then 
	if IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group)) then lidminus:=1; 
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group))=false then lidminus:=2; 
	elif IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group))=false then lidminus:=2;
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group)) then lidminus:=1; fi;
else
if IsSubgroup(group,AsGroup(RDA)) then lidminus:=Order(group)/Length(RDA); else
RCA:=RC(group, subsetA); 
lowerbound:=Int(Ceil(Order(group)/Length(RDA)+0.0));
upperbound:=Int(Order(group)/Length(subsetA));
if lowerbound=upperbound then lidminus:=upperbound; else
flag:=0;
k:=lowerbound;
identity:=Identity(group);
while flag=0 and k<=upperbound do
	for B in Combinations(RCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, B,RDA)) and Intersection(RDA,LD(group, B))=[identity] then
			lidminus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k+1;
	od;
fi; fi; fi; fi;
return lidminus;
end;	

LidPlus:= function(group, subsetA)
local lidplus,lowerbound,upperbound,RCA,k,B,flag,RDA,identity,LDA;
LDA:=LD(group, subsetA);
RDA:=RD(group, subsetA);
if Length(subsetA)<=1 then lidplus:=Order(group); 
else
if Length(subsetA) > Int(Order(group)/2) then lidplus:=1; lidplus:=1; 
elif Length(subsetA) > Int(Order(group)/3) and (Length(subsetA)) <= Int(Order(group)/2) then 
	if IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group)) then lidplus:=1; 
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group))=false then lidplus:=2; 
	elif IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group))=false then lidplus:=2;
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group)) then lidplus:=1; fi;
else
if IsSubgroup(group,AsGroup(RDA)) then lidplus:=Order(group)/Length(RDA); else
RCA:=RC(group, subsetA); 
lowerbound:=Int(Ceil(Order(group)/Length(RDA)+0.0));
upperbound:=Int(Order(group)/Length(subsetA));
if lowerbound=upperbound then lidplus:=upperbound; else
flag:=0;
k:=upperbound;
identity:=Identity(group);
while flag=0 and k>=lowerbound do
	for B in Combinations(RCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, B,RDA)) and Intersection(RDA,LD(group, B))=[identity] then
			lidplus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k-1;
	od;
fi; fi; fi; fi;
return lidplus;
end;

LidMP:= function(group, subsetA)
local lidminus,lidplus,lowerbound,upperbound,RCA,k,B,flag,RDA,identity,LDA;
RDA:=RD(group, subsetA);
LDA:=LD(group, subsetA);
if Length(subsetA)<=1 then lidminus:=Order(group); lidplus:=lidminus; 
else
if Length(subsetA) > Int(Order(group)/2) then lidminus:=1; lidplus:=1; 
elif Length(subsetA) > Int(Order(group)/3) and Length(subsetA) <= Int(Order(group)/2) then 
	if IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group)) then lidminus:=1; lidplus:=1; 
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group))=false then lidminus:=2; lidplus:=2;
	elif IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group))=false then lidminus:=2; lidplus:=2;
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group)) then lidminus:=1; lidplus:=1; fi;
else 
if IsSubgroup(group,AsGroup(RDA)) then lidminus:=Order(group)/Length(RDA); lidplus:=lidminus; else
RCA:=RC(group, subsetA); 
lowerbound:=Int(Ceil(Order(group)/Length(RD(group, subsetA))+0.0));
upperbound:=Int(Order(group)/Length(subsetA));
if lowerbound=upperbound then lidminus:=upperbound; else
flag:=0;
k:=lowerbound;
identity:=Identity(group);
while flag=0 and k<=upperbound do
	for B in Combinations(RCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, B,RDA)) and Intersection(RDA,LD(group, B))=[identity] then
			lidminus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k+1;
	od;
fi;
if lidminus=upperbound then lidplus:=lidminus; else
flag:=0;
k:=upperbound;
while flag=0 and k>=lowerbound do
	for B in Combinations(RCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, B,RDA)) and Intersection(RDA,LD(group, B))=[identity] then
			lidplus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k-1;
	od;
fi; fi; fi; fi;
return [lidminus,lidplus];
end;

LidPM:= function(group, subsetA)
local lidminus,lidplus,lowerbound,upperbound,RCA,k,B,flag,RDA,identity,LDA;
RDA:=RD(group, subsetA);
LDA:=LD(group, subsetA);
if Length(subsetA)<=1 then lidminus:=Order(group); lidplus:=lidminus; 
else
if Length(subsetA) > Int(Order(group)/2) then lidminus:=1; lidplus:=1; 
elif Length(subsetA) > Int(Order(group)/3) and Length(subsetA) <= Int(Order(group)/2) then 
	if IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group)) then lidminus:=1; lidplus:=1; 
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group))=false then lidminus:=2; lidplus:=2;
	elif IsEqualSet(LDA,Elements(group)) and IsEqualSet(RDA,Elements(group))=false then lidminus:=2; lidplus:=2;
	elif IsEqualSet(LDA,Elements(group))=false and IsEqualSet(RDA,Elements(group)) then lidminus:=1; lidplus:=1; fi;
else 
if IsSubgroup(group,AsGroup(RDA)) then lidminus:=Order(group)/Length(RDA); lidplus:=lidminus; else
RCA:=RC(group, subsetA); 
lowerbound:=Int(Ceil(Order(group)/Length(RDA)+0.0));
upperbound:=Int(Order(group)/Length(subsetA));
if lowerbound=upperbound then lidplus:=upperbound; else
flag:=0;
k:=upperbound;
identity:=Identity(group);
while flag=0 and k>=lowerbound do
	for B in Combinations(RCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, B,RDA)) and Intersection(RDA,LD(group, B))=[identity] then
			lidplus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k-1;
	od;
fi;
if lidplus=lowerbound then lidminus:=lidplus; else
flag:=0;
k:=lowerbound;
while flag=0 and k<=upperbound do
	for B in Combinations(RCA,k-1) do
		AddSet(B,identity);
		if IsEqualSet(Elements(group),Mul(group, B,RDA)) and Intersection(RDA,LD(group, B))=[identity] then
			lidminus:=k;
			flag:=1;
			break;
			fi;
		od;
	k:=k+1;
	od;
fi; fi; fi; fi;
return [lidminus,lidplus];
end;	

Rid:= function(group, subsetA)
local ridpm,rid;
ridpm:=RidPM(group, subsetA);
if ridpm[1]=ridpm[2] then rid:=ridpm[1];
else rid:=fail; #Rid+(subsetA) is not equal to Rid-(subsetA) i.e, subsetA is not right index stable
fi; 
return rid;
end;

Lid:= function(group, subsetA)
local lidpm,lid;
lidpm:=LidPM(group, subsetA);
if lidpm[1]=lidpm[2] then lid:=lidpm[1];
else lid:=fail; #Lid+(subsetA) is not equal to Lid-(subsetA) i.e, subsetA is not left index stable
fi;
return lid;
end;

Id:= function(group, subsetA)
local lid,rid,id;
rid:=Rid(group, subsetA);
lid:=Lid(group, subsetA);
if rid<>fail and lid<>fail and rid=lid then id:=rid; 
else id:=fail; #Rid(subsetA) (or Lid(subsetA))  is not defined or Rid(subsetA) is not equal to Lid(subsetA) i.e, subsetA is not index stable 
fi;
return id;
end;

IdPlus:= function(group, subsetA)
local lidplus,idplus;
lidplus:=LidPlus(group, subsetA);
if RidPlus(group, subsetA)=lidplus then idplus:=lidplus;
else idplus:=fail; #Rid+(subsetA) is not equal to Lid+(subsetA) i.e, subsetA is not upper index stable"
fi;
return idplus;
end;

IdMinus:= function(group, subsetA)
local lidminus,idminus;
lidminus:=LidMinus(group, subsetA);
if RidMinus(group, subsetA)=lidminus then idminus:=lidminus;
else idminus:=fail; #Rid-(subsetA) is not equal to Lid-(subsetA) i.e, subsetA is not lower index stable
fi;
return idminus;
end;

IsRightkIndexStable:= function(group, k)
local elements,identity,RIndexStable,ksubsetswith1,A,rimpm;
elements:=Elements(group);
identity:=elements[1];
elements:=Difference(elements,[identity]);
RIndexStable:=true;
ksubsetswith1:=Combinations(elements,k-1);
for A in ksubsetswith1 do
	Add(A,identity);
	A:=Set(A);
	if Int(Ceil(Order(group)/Length(LD(group, A))+0.0))<>Int(Order(group)/Length(A)) and IsSubgroup(group,AsGroup(Set(LD(group, A))))=false then
	    rimpm:=RidPM(group, A);
		if rimpm[1]<>rimpm[2] then 
			RIndexStable:=false;
			break;
		fi;
	fi;
od;
return RIndexStable;
end;

IskIndexStable:= function(group, k)
local elements,identity,RIndexStable,IndexStable,ksubsetswith1,A,rimpm,limpm;
RIndexStable:=IsRightkIndexStable(group, k);
if RIndexStable then 
	if IsAbelian(group) then 
		IndexStable:=true;
	else
		elements:=Elements(group);
		identity:=elements[1];
		elements:=Difference(elements,[identity]);
		IndexStable:=true;
		ksubsetswith1:=Combinations(elements,k-1);
		for A in ksubsetswith1 do
			Add(A,identity);
			A:=Set(A);
			if IsEqualSet(RD(group, A),LD(group, A))=false or IsSubgroup(group,AsGroup(Set(LD(group, A))))=false then
				rimpm:=RidPM(group, A);
				limpm:=LidPM(group, A);
				if Length(Union(rimpm,limpm))<>1 then;
					IndexStable:=false;
					break;
				fi;
			fi;
		od;
	fi;
else 
	IndexStable:=false;
fi;
return [RIndexStable,IndexStable];
end;

IsRightIndexStable:= function(group,k)
return ForAll([2..Int(Order(group)/2)],k->IsRightkIndexStable(group, k));
end;

IsIndexStable:= function(group)
return ForAll([2..Int(Order(group)/2)],k->IskIndexStable(group, k)[2]);
end;
	
RDn:= function(group, n, subsetA)
local C,i;
C:=subsetA;
if n>0 then
	for i in [1..n] do
		C:=RD(group ,C);
	od;
fi;
return C;
end;

LDn:= function(group, n, subsetA)
local C,i;
C:=subsetA;
if n>0 then
	for i in [1..n] do
		C:=LD(group, C);
	od;
fi;
return C;
end;

RDl:= function(group, subsetA)
local flag,n,C,RDC;
flag:=0;
n:=0;
C:=subsetA;
while flag<>1 do
	RDC:=RD(group, C);
	if RDC=C then flag:=1; else C:=RDC; n:=n+1; fi;
od;
return n;	
end;

LDl:= function(group, subsetA)
local flag,n,C,LDC;
flag:=0;
n:=0;
C:=subsetA;
while flag<>1 do
	LDC:=LD(group, C);
	if LDC=C then flag:=1; else C:=LDC; n:=n+1; fi;
od;
return n;	
end;

RDD:= function(group, subsetA)
local flag,n,C,RDC;
flag:=0;
n:=0;
C:=subsetA;
while flag<>1 do
	RDC:=RD(group, C);
	if RDC=C then flag:=1; else C:=RDC; n:=n+1; fi;
od;
return AsGroup(C);	
end;

LDD:= function(group, subsetA)
local flag,n,C,LDC;
flag:=0;
n:=0;
C:=subsetA;
while flag<>1 do
	LDC:=LD(group, C);
	if LDC=C then flag:=1; else C:=LDC; n:=n+1; fi;
od;
return AsGroup(C);	
end;

Rlag:= function(group, subsetA)
local flag,n,C,RDC;
flag:=0;
n:=0;
C:=RD(group, subsetA);
if not IsEqualSet(C,subsetA) then
while flag<>1 do
	if RemInt(Order(group),Length(C))=0 then n:=n+1; fi;
	RDC:=RD(group, C);
	if RDC=C then flag:=1; else C:=RDC; fi;
od;
fi;
return n;
end;

Llag:= function(group, subsetA)
local flag,n,C,LDC;
flag:=0;
n:=0;
C:=LD(group, subsetA);
if not IsEqualSet(C,subsetA) then
while flag<>1 do
	if RemInt(Order(group),Length(C))=0 then n:=n+1; fi;
	LDC:=LD(group, C);
	if LDC=C then flag:=1; else C:=LDC; fi;
od;
fi;
return n;
end;

RISS:= function(group)
return Filtered(Difference(Combinations(Elements(group)),[[]]),A->Length(Set(RidPM(group,A)))=1);
end;

LISS:= function(group)
return Filtered(Difference(Combinations(Elements(group)),[[]]),A->Length(Set(LidPM(group,A)))=1);
end;

ISS:= function(group)
return Filtered(Difference(Combinations(Elements(group)),[[]]),A->Length(Union(RidPM(group,A),LidPM(group,A)))=1);
end;

IndR:= function(group)
local A,indices,subsets,PM;
indices:=[];
subsets:=Difference(Combinations(Elements(group)),[[]]);
for A in subsets do;
	PM:=RidPM(group, A);
	if PM[1]=PM[2] then Add(indices,PM[1]); fi;
od;
return Set(indices);
end;

IndL:= function(group)
local A,indices,subsets,PM;
indices:=[];
subsets:=Difference(Combinations(Elements(group)),[[]]);
for A in subsets do;
	PM:=LidPM(group. A);
	if PM[1]=PM[2] then Add(indices,PM[1]); fi;
od;
return Set(indices);
end;

Indsl:= function(group)
local A,indices,subsets,PM1,PM2;
indices:=[];
subsets:=Difference(Combinations(Elements(group)),[[]]);
for A in subsets do;
	PM1:=RidPM(group,A);
	PM2:=LidPM(group,A);
	AddSet(indices,PM1[1]);AddSet(indices,PM1[2]);AddSet(indices,PM2[1]);AddSet(indices,PM2[2]);
od;
return Set(indices);
end;

Ind:= function(group)
local indices,A,subsets,SPM,PM1,PM2;
indices:=[];
subsets:=Difference(Combinations(Elements(group)),[[]]);
for A in subsets do;
	PM1:=RidPM(group,A);
	PM2:=LidPM(group,A);
	SPM:=Set([PM1[1],PM1[2],PM2[1],PM2[2]]);
	if Length(SPM)=1 then Add(indices,SPM[1]); fi;
od;
return Set(indices);
end;


IndMinus:= function(group)
local indices,A,subsets,SPM;
indices:=[];
subsets:=Difference(Combinations(Elements(group)),[[]]); 
for A in subsets do;
	SPM:=Set([RidPlus(group,A),LidPlus(group,A)]);
	if Length(SPM)=1 then Add(indices,SPM[1]); fi;
od;
return Set(indices);
end;

IndPlus:= function(group)
local indices,A,subsets,SPM;
indices:=[];
subsets:=Difference(Combinations(Elements(group)),[[]]); 
for A in subsets do;
	SPM:=Set([RidPlus(group,A),LidPlus(group,A)]);
	if Length(SPM)=1 then Add(indices,SPM[1]); fi;
	od;
return Set(indices);
end;

IndslMinus:= function(group)
local indices,A,subsets,SPM;
indices:=[];
subsets:=Difference(Combinations(Elements(group)),[[]]); 
for A in subsets do;
	Add(indices,RidMinus(group,A)); Add(indices,LidMinus(group,A));
	od;
return Set(indices);
end;

IndslPlus:= function(group)
local indices,A,subsets,SPM;
indices:=[];
subsets:=Difference(Combinations(Elements(group)),[[]]); 
for A in subsets do;
	Add(indices,RidPlus(group,A)); Add(indices,LidPlus(group,A));
	od;
return Set(indices);
end;

IndslL:= function(group)
local indices,A,subsets,SPM;
indices:=[];
subsets:=Difference(Combinations(Elements(group)),[[]]); 
for A in subsets do;
    SPM:=LidPM(group,A);
	Add(indices,SPM[1]); Add(indices,SPM[2]);
	od;
return Set(indices);
end;

IndslR:= function(group)
local indices,A,subsets,SPM;
indices:=[];
subsets:=Difference(Combinations(Elements(group)),[[]]); 
for A in subsets do;
    SPM:=RidPM(group,A);
	Add(indices,SPM[1]); Add(indices,SPM[2]);
	od;
return Set(indices);
end;


Num:= function(group)
return Union([1..Int(Order(group)/2)],[Order(group)]);
end;

IsRightIndexPervasive:= function(group)
return IsEqualSet(IndR(group),Num(group));
end;

IsLeftIndexPervasive:= function(group)
return IsEqualSet(IndL(group),Num(group));
end;

IsIndexPervasive:= function(group)
return IsEqualSet(Ind(group),Num(group));
end;

IsSubIndexPervasive:= function(group)
return IsEqualSet(Indsl(group),Num(group));
end;
