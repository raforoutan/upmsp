function q=Reversion(x)

        n=numel(x(1,:));
        i=sort(randsample(n,2));
        q=x;
        q(:,i(1):i(2))=x(:,i(2):-1:i(1));
end