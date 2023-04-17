clc
clear all
close all
format shortG
%%
V=0.5;
A=xlsread('mcdm.xlsx',1);
%A=readcell('mcdm.xlsx');
W=A(1,:);
DM=A(3:end,:);

[na,nc]=size(DM);




%% Step 1
FP=zeros(1,nc);
FN=zeros(1,nc);

for c=1:nc
    
    if W(c)>0
    FP(c)=max(DM(:,c));
    FN(c)=min(DM(:,c));    
    else
    FP(c)=min(DM(:,c));
    FN(c)=max(DM(:,c));
    end
    

end



%% step 2

W=abs(W);

S=zeros(1,na);
R=zeros(1,na);

for a=1:na
    
E=zeros(1,nc);

for c=1:nc
    
    p=W(c)*(FP(c)-DM(a,c))/(FP(c)-FN(c));
    E(c)=p;       
    
end

S(a)=sum(E);
R(a)=max(E);

end



%% step 3

SP=min(S);
SN=max(S);

RP=min(R);
RN=max(R);

Q=zeros(1,na);


for a=1:na
    
    
s=(SP-S(a))/(SP-SN);
r=(RP-R(a))/(RP-RN);

Q(a)=V*s+(1-V)*r;


end





%% Results

disp('****************** Q ******************')
[value,index]=sort(Q);

for a=1:na 
disp(['Rank' num2str(a) ' Alter' num2str(index(a)) ' Q = ' num2str(value(a))])
end
disp(' ')


disp('****************** S ******************')
[value,index]=sort(S);

for a=1:na 
disp(['Rank' num2str(a) ' Alter' num2str(index(a)) ' S = ' num2str(value(a))])
end
disp(' ')


disp('****************** R ******************')
[value,index]=sort(R);

for a=1:na 
disp(['Rank' num2str(a) ' Alter' num2str(index(a)) ' R = ' num2str(value(a))])
end
disp(' ')


%% Matlabhome.ir **** Vikor Method MCDM *** Free Download Farsi *** Videos Matlab Code  File Book %%
