function q=Swap(x)

        Input=CreateInput;

        n=numel(x(1,:));
        i=randsample(n,2);
        q=x;
        q(:,[i(1) i(2)])=x(:,[i(2) i(1)]);
        
        q=RepairSolution(q,Input);
end