function Archive=SaveStrategy(sol,Archive)

        J=numel(Archive);
        sol.N=0;
        for i=1:J             
              if all(Archive(i).Z>=sol.Z)&& any(Archive(i).Z>sol.Z)
                  sol.N=sol.N + 1;          
              elseif all(sol.Z>=Archive(i).Z)&& any(sol.Z>Archive(i).Z)

                    Archive(i).N=Archive(i).N + 1;
              end
        end
        [v,L]=find([Archive.N]>0);
        Archive(L)=[];
        if sol.N==0;
           Archive=[Archive sol]; 
        end
end