function q=Insertion(x)

        n=numel(x(1,:));
        i=randsample(n,2);
        i1=i(1);
        i2=i(2);
        
        if i1<i2
            q=[x(:,1:i1-1) x(:,i1+1:i2) x(:,i1) x(:,i2+1:end)];
        else
            q=[x(:,1:i2) x(:,i1) x(:,i2+1:i1-1) x(:,i1+1:end)];
        end
end