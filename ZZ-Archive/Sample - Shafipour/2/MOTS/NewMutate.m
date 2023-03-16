function q=NewMutate(x)

        n=numel(x(1,:));
        i=randsample(n,2);
        
        q=x;
        q(3,i)=x(3,i)-1;
        q(3,:)=max(1,q(3,:));


end