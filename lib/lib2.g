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
