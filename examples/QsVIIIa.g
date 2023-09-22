Qs_VIII_a:= function(n)
for G in AllSmallGroups([1..n]) do
    Print(StructureDescription(G)," :", [IndslPlus(G)=Num(G),IndslMinus(G)=Num(G),IndslR(G)=Num(G),IndslL(G)=Num(G),IndPlus(G)=Num(G),IndMinus(G)=Num(G),Ind(G)=Num(G)], "\n"); od;
return;
end;
# gap> QsVIIIa(14)
# 1 :[ true, true, true, true, true, true, true ]
# C2 :[ true, true, true, true, true, true, true ]
# C3 :[ true, true, true, true, true, true, true ]
# C4 :[ true, true, true, true, true, true, true ]
# C2 x C2 :[ true, true, true, true, true, true, true ]
# C5 :[ true, true, true, true, true, true, true ]
# S3 :[ true, true, true, true, true, true, true ]
# C6 :[ true, true, true, true, true, true, true ]
# C7 :[ true, true, true, true, true, true, true ]
# C8 :[ false, true, true, true, false, false, false ]
# C4 x C2 :[ false, false, false, false, false, false, false ]
# D8 :[ false, false, false, false, false, false, false ]
# Q8 :[ false, false, false, false, false, false, false ]
# C2 x C2 x C2 :[ false, false, false, false, false, false, false ]
# C9 :[ true, false, true, true, true, true, false ]
# C3 x C3 :[ false, false, false, false, false, false, false ]
# D10 :[ true, false, true, true, true, true, false ]
# C10 :[ true, false, true, true, true, true, false ]
# C11 :[ false, false, true, true, false, false, false ]
# C3 : C4 :[ false, false, false, false, false, false, false ]
# C12 :[ false, false, false, false, false, false, false ]
# A4 :[ false, false, false, false, false, false, false ]
# D12 :[ false, false, false, false, false, false, false ]
# C6 x C2 :[ false, false, false, false, false, false, false ]
# C13 :[ false, false, true, true, false, false, false ]
# D14 :[ false, false, false, false, false, false, false ]
# C14 :[ false, true, true, true, false, false, false ]
