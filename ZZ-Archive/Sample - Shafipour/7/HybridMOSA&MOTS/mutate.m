function q=mutate(x)

         r=randsample(4,1);
         
         switch r
             case 1
                    q=Swap(x);
             case 2
                    q=Reversion(x);
             case 3
                    q=Insertion(x);
             case 4
                    q=NewMutate(x);
         end        
end