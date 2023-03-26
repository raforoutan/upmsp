function[v1,v2]=SinglePointCrossover(x1,x2)

        Input=CreateInput;
        B=Input.B;
        F=Input.F;
        lambda1=Input.lambda1;
        lambda2=Input.lambda2;

        n=numel(x1(1,:));
        c=randi([1 n-1]);
        
        v1=[x1(:,1:c) x2(:,c+1:end)];
        v2=[x2(:,1:c) x1(:,c+1:end)];
        
        % first child
        [e,f]=intersect(v1(1,1:c),v1(1,c+1:end));
        v1(:,f)=0;
        
        % second child
        [a,L]=intersect(v2(1,1:c),v2(1,c+1:end));
        v2(:,L)=0;
        
        q=1;
        for i=1:n
            if v1(1,i)==0
                k=find(v2(1,:)==a(q));
                v1(:,i)=v2(:,k); 
                q=q+1;
            end
        end
        
        m=1;
        for j=1:n
            if v2(1,j)==0
                r=find(v1(1,:)==e(m));
                v2(:,j)=v1(:,r);
                m=m+1;
            end
        end
 
        
nBatch=zeros(1,B);
for i=1:numel(v1(1,:))
    for j=1:B
        if lambda1(v1(1,i),j)==1 && nBatch(j)==0
            nBatch(j)=v1(2,i);
        end
    end
end
for i=1:numel(v1(1,:))
    for j=1:B
       if lambda1(v1(1,i),j)==1
           v1(2,i)=nBatch(j);
       end
    end
end

nBatch=zeros(1,B);
for i=1:numel(v2(1,:))
    for j=1:B
        if lambda1(v2(1,i),j)==1 && nBatch(j)==0
            nBatch(j)=v2(2,i);
        end
    end
end
for i=1:numel(v2(1,:))
    for j=1:B
       if lambda1(v2(1,i),j)==1
           v2(2,i)=nBatch(j);
       end
    end
end

nFamily=zeros(1,F);
for i=1:numel(v1(1,:))
    for j=1:F
        if lambda2(v1(1,i),j)==1 && nFamily(j)==0
            nFamily(j)=v1(2,i);
        end
    end
end
for i=1:numel(v1(1,:))
    for j=1:F
       if lambda2(v1(1,i),j)==1
           v1(2,i)=nFamily(j);
       end
    end
end

nFamily=zeros(1,F);
for i=1:numel(v2(1,:))
    for j=1:F
        if lambda2(v2(1,i),j)==1 && nFamily(j)==0
            nFamily(j)=v2(2,i);
        end
    end
end
for i=1:numel(v2(1,:))
    for j=1:F
       if lambda2(v2(1,i),j)==1
           v2(2,i)=nFamily(j);
       end
    end
end
            
        
        v1=RepairSolution(v1,Input);
        v2=RepairSolution(v2,Input);
end
