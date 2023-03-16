function Output = CreateOutput(Paretolist)

num=numel(Paretolist);
objfun1=[];
objfun2=[];
objfun3=[];
for i=1:num
    objfun1=[objfun1 Paretolist(i).cost(1)];
    objfun2=[objfun2 Paretolist(i).cost(2)];
    objfun3=[objfun3 Paretolist(i).cost(3)];
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
    ci(i)=sqrt(((Paretolist(i).cost(1)-f1best)/(f1max-f1min))^2+((Paretolist(i).cost(2)-f2best)/(f2max-f2min))^2+((Paretolist(i).cost(3)-f3best)/(f3max-f3min))^2);
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
    ci3(i)=abs(((Paretolist(i).cost(1))-f1best)/f1best)+abs(((Paretolist(i).cost(2))-f2best)/f2best)+abs(((Paretolist(i).cost(3))-f3best)/f3best);  
end

RAS=sum(ci3)/num;

Output.NPS=NPS;
Output.MID=MID;
Output.DM=DM;
Output.SNS=SNS;
Output.RAS=RAS;

end