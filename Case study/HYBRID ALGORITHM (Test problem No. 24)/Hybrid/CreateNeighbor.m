function pop=CreateNeighbor(X,Input,Tabulist,Neighborsize,NewPrecedency)


        pop=[];
        n=0;
        while numel(pop)<Neighborsize
            
            
           Xnew.position=Mutate(X.position);            % Create new solution
           
           Xnew.Z=SchedulingCost(Xnew.position,NewPrecedency,Input);
           
           Q=Nondominate(Xnew.Z,X.Z);
           if Q
            for j=1:numel(Tabulist)
                   q=Xnew.position;
                   f=Tabulist(j).position;
                  k=find(q==f);
                  if numel(k)==numel(X.position)
                      n=n+1;
                      break;
                  end 
            end
            if n==0
                pop=[pop
                     Xnew];
            end
           end
            n=0;
        end
end