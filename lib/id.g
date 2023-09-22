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