function Output = CreateOutput(F1)

for j=1:numel(F1)
    F1(j).nps=F1(j).Cost;
end

for i=numel(F1):-1:2
    for j = 1:i-1
        if isequal(F1(i).nps,F1(j).nps)
            F1(i).nps=[];
            break
        end
    end
end
% Paretolist(:).nps;

h=0;
for i=1:numel(F1)
    if ~isempty(F1(i).nps)
        h=h+1;
    end
end

Paretolist2=cell(h,1);
z=1;
for i=1:numel(F1)
    if ~isempty(F1(i).nps)
        Paretolist2{z}=[F1(i).nps];
        z=z+1;
    end
end

num=numel(Paretolist2);
objfun1=[];
objfun2=[];
objfun3=[];
for i=1:num
    objfun1=[objfun1 Paretolist2{i}(1)];
    objfun2=[objfun2 Paretolist2{i}(2)];
    objfun3=[objfun3 Paretolist2{i}(3)];
end
f1min=min(objfun1);
f1max=max(objfun1);
f2min=min(objfun2);
f2max=max(objfun2);
f3min=min(objfun3);
f3max=max(objfun3);

f1best=f1min;
f2best=f2min;
f3best=f3min;

ci=zeros(1,num);
for i=1:num
    ci(i)=sqrt(((Paretolist2{i}(1)-f1best)/(f1max-f1min))^2+((Paretolist2{i}(2)-f2best)/(f2max-f2min))^2+((Paretolist2{i}(3)-f3best)/(f3max-f3min))^2);
end

NPS=num;
MID=sum(ci)/num;
ci2=zeros(1,num);
for i=1:num
    ci2(i)=(MID-ci(i))^2;  
end

DM=sqrt((f1max-f1min)^2+(f2max-f2min)^2+(f3max-f3min)^2);
SNS=sqrt(sum(ci2)/(num-1));

ci3=zeros(1,num);
for i=1:num
    ci3(i)=abs(((Paretolist2{i}(1))-f1best)/f1best)+abs(((Paretolist2{i}(2))-f2best)/f2best)+abs(((Paretolist2{i}(3))-f3best)/f3best);  
end

RAS=sum(ci3)/num;


Output.NPS=NPS;
Output.MID=MID;
Output.DM=DM;
Output.SNS=SNS;
Output.RAS=RAS;
Output.Paretolist2=Paretolist2;
Output.F1=F1;

end