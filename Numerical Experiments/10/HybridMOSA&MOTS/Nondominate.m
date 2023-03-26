function q=Nondominate(X,Y) 

        if all(X<=Y)&& any(X<Y)
            q=1;
        elseif all(Y<=X)&& any(Y<X)
            q=0;
        else
            q=1;
        end
end