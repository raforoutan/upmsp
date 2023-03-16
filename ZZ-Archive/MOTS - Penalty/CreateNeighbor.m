function pop=CreateNeighbor(x,Input,Tabulist,Neighborsize)


        pop=[];
        n=0;
        while numel(pop)<Neighborsize
            [NewPrecedency]=RepairSolution(Input);
            aa=randi(2);
            if aa==1
                Xnew.position=Mutate(x.position);
            else
                Xnew.position=Crossover(x.position,x.position);
            end
%              Xnew.position=Mutate(x.position);
           
           Xnew.cost=SchedulingCost(Xnew.position,NewPrecedency,Input);
           
           Q=Nondominate(Xnew.cost,x.cost);
           if Q
            for j=1:numel(Tabulist)
                   q=Xnew.position;
                   f=Tabulist(j).position;
                  k=find(q==f);
                  if numel(k)==numel(x.position)
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