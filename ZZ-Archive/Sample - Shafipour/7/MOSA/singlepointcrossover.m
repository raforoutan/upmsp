function[v1,v2]=singlepointcrossover(x1,x2)

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
end