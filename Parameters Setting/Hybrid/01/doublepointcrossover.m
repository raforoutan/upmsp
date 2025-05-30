function [C1,C2]=DoublePointCrossover(x1,x2)

    Input=CreateInput;
    B=Input.B;
    F=Input.F;
    lambda1=Input.lambda1;
    lambda2=Input.lambda2;
     
     nvar=numel(x1(1,:));
     i=sort(randsample(nvar-1,2));
     n=1;u=1;
     v1=[x1(:,1:i(1)) x2(:,i(1)+1:i(2)) x1(:,i(2)+1:end)];
     v2=[x2(:,1:i(1)) x1(:,i(1)+1:i(2)) x2(:,i(2)+1:end)];
     % first Child
     v=[v1(:,1:i(1)) v1(:,i(2)+1:end)];
     [a,j]=intersect(v(1,:),v1(1,i(1)+1:i(2)));
     v(:,j)=0;
     v1=[v(:,1:i(1)) v1(:,i(1)+1:i(2)) v(:,i(1)+1:end)];
     % second Child
     y=[v2(:,1:i(1)) v2(:,i(2)+1:end)];
     [e,f]=intersect(y(1,:),v2(1,i(1)+1:i(2)));
     y(:,f)=0;
     v2=[y(:,1:i(1)) v2(:,i(1)+1:i(2)) y(:,i(1)+1:end)];

     for i=1:nvar
         if v1(1,i)==0
             k=find(x2(1,:)==e(n));
             v1(:,i)=x2(:,k);
             n=n+1;
         end
     end
     C1=v1;
     for i=1:nvar
        if v2(1,i)==0
           r=find(x1(1,:)==a(u));
           v2(:,i)=x1(:,r);
           u=u+1;
        end
     end
     C2=v2;
     
     
nBatch=zeros(1,B);
for i=1:numel(C1(1,:))
    for j=1:B
        if lambda1(C1(1,i),j)==1 && nBatch(j)==0
            nBatch(j)=C1(2,i);
        end
    end
end
for i=1:numel(C1(1,:))
    for j=1:B
       if lambda1(C1(1,i),j)==1
           C1(2,i)=nBatch(j);
       end
    end
end

nBatch=zeros(1,B);
for i=1:numel(C2(1,:))
    for j=1:B
        if lambda1(C2(1,i),j)==1 && nBatch(j)==0
            nBatch(j)=C2(2,i);
        end
    end
end
for i=1:numel(C2(1,:))
    for j=1:B
       if lambda1(C2(1,i),j)==1
           C2(2,i)=nBatch(j);
       end
    end
end

nFamily=zeros(1,F);
for i=1:numel(C1(1,:))
    for j=1:F
        if lambda2(C1(1,i),j)==1 && nFamily(j)==0
            nFamily(j)=C1(2,i);
        end
    end
end
for i=1:numel(C1(1,:))
    for j=1:F
       if lambda2(C1(1,i),j)==1
           C1(2,i)=nFamily(j);
       end
    end
end

nFamily=zeros(1,F);
for i=1:numel(C2(1,:))
    for j=1:F
        if lambda2(C2(1,i),j)==1 && nFamily(j)==0
            nFamily(j)=C2(2,i);
        end
    end
end
for i=1:numel(C2(1,:))
    for j=1:F
       if lambda2(C2(1,i),j)==1
           C2(2,i)=nFamily(j);
       end
    end
end
       
     C1=RepairSolution(C1,Input);
     C2=RepairSolution(C2,Input);
end