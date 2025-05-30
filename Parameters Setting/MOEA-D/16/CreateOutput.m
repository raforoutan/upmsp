function Output = CreateOutput(EP)

for j=1:numel(EP)
    EP(j).nps=EP(j).Cost;
end

for i=numel(EP):-1:2
    for j = 1:i-1
        if isequal(EP(i).nps,EP(j).nps)
            EP(i).nps=[];
            break
        end
    end
end
% Paretolist(:).nps;

h=0;
for i=1:numel(EP)
    if ~isempty(EP(i).nps)
        h=h+1;
    end
end

Paretolist2=cell(h,1);
z=1;
for i=1:numel(EP)
    if ~isempty(EP(i).nps)
        Paretolist2{z}=[EP(i).nps];
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
    best=min(Paretolist2{i});
    ci3(i)=abs(((Paretolist2{i}(1))-best)/best)+abs(((Paretolist2{i}(2))-best)/best)+abs(((Paretolist2{i}(3))-best)/best);  
end
RAS=sum(ci3)/num;


ci4=zeros(1,num);
for i=1:num
    ci4(i)=abs(((Paretolist2{i}(1))-f1best)/f1best)+abs(((Paretolist2{i}(2))-f2best)/f2best)+abs(((Paretolist2{i}(3))-f3best)/f3best);  
end

RAS2=sum(ci4)/num;


Output.NPS=NPS;
Output.MID=MID;
Output.DM=DM;
Output.SNS=SNS;
Output.RAS=RAS;
Output.RAS2=RAS2;
Output.Paretolist2=Paretolist2;
Output.EP=EP;

end