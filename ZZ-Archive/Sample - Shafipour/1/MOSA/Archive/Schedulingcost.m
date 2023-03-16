function [Z , sol]=Schedulingcost(x,Input)

        P=Input.P;
        M=Input.M;
        J=Input.J;
        S=Input.S;
        K=Input.K;
        D=Input.D;
        Cemployee=Input.C;
        pi=Input.pi;
        Precedence=Input.Precedence;
        w=Input.w;
        % Frist function
        x=RepairSolution(x,Input);
        L=cell(M,1);
        for i=1:M
           l=find(x(2,:)==i);
           L{i}(1,:)=x(1,l);
           L{i}(2,:)=x(3,l);
        end

        st=zeros(1,J);
        ft=zeros(1,J);
        
        T=zeros(1,J);
%         E=zeros(1,J);
        
        stworker=zeros(M,K);
        ftworker=zeros(M,K);
        Ynew=zeros(1,J);
        cost=zeros(1,J);
        z=1;
        
   while numel(find(ft>0))~=numel(ft)     
        for j=1:M
           for i=L{j}(1,:)
             k=find(L{j}(1,:)==i);
             r=find(Ynew(1,:)==i);
             if r
                 continue;
             else
              if k==1
                   
                   if isempty(Precedence{i})  
                   st1=0;
                   stworker(j,L{j}(2,k))=max(max(ftworker(:,L{j}(2,k)),st1));
                   ftworker(j,L{j}(2,k))=stworker(j,L{j}(2,k))+S(i,i,j,L{j}(2,k));
                   st(i)=ftworker(j,L{j}(2,k));
                   ft(i)=st(i)+ P(i,j) ;
                   Ynew(z)=i;
                   z=z+1;
                    
                   else
                       kk=Precedence{i} ;
                       if numel(kk)==numel(intersect(kk,Ynew))  
                           st1=max(ft(kk)) ;
                           stworker(j,L{j}(2,k))=max(max(ftworker(:,L{j}(2,k)),st1));
                           ftworker(j,L{j}(2,k))=stworker(j,L{j}(2,k))+S(i,i,j,L{j}(2,k));
                           st(i)=ftworker(j,L{j}(2,k));
                           ft(i)=st(i)+ P(i,j) ;
                           Ynew(z)=i;
                           z=z+1;
                       else
                         break;
                       end
                   end 
%                stworker(j,L{j}(2,k))=max(ftworker(:,L{j}(2,k),st1));
%                ftworker(j,L{j}(2,k))=stworker(j,L{j}(2,k))+S(i,i,j,L{j}(2,k));
%                st(i)=ftworker(j,L{j}(2,k));
              else
                if isempty(Precedence{i})
%                    st(i)=ft(L{j}(k-1))+S(i);
                  previosjob=L{j}(1,k-1);
                  stworker(j,L{j}(2,k))=max(max(ftworker(:,L{j}(2,k))),ft(previosjob));
                  ftworker(j,L{j}(2,k))=stworker(j,L{j}(2,k))+S(previosjob,i,j,L{j}(2,k));
                  st(i)=ftworker(j,L{j}(2,k)); 
                  ft(i)=st(i)+ P(i,j) ;       
                  Ynew(z)=i;
                  z=z+1;                  
                else
                    
                   kk=Precedence{i} ;
                   if numel(kk)==numel(intersect(kk,Ynew)) 
                      previosjob=L{j}(1,k-1);
                      st1=max(ft(kk)) ;
                      stworker(j,L{j}(2,k))=max(max(max(ftworker(:,L{j}(2,k)),st1),ft(previosjob)));
                      ftworker(j,L{j}(2,k))=stworker(j,L{j}(2,k))+S(previosjob,i,j,L{j}(2,k));
                      st(i)=ftworker(j,L{j}(2,k));                                  
                      ft(i)=st(i)+ P(i,j) ;
                      Ynew(z)=i;
                      z=z+1;
                   else
                       break;
                   end                       
                end
              end
%               ft(i)=st(i)+P(i,j);
            T(i)=max(ft(i)-D(i),0);
%             E(i)=max(D(i)-ft(i),0);
%             cost(i)=5*T(i)+3*E(i);
            cost(i)=w(i)*T(i);
             end
           end
        end
        
   end
        Z1=sum(cost);
        
        
        % Second function
        Z2=0;
        for t=1:J
           Z2= Z2 + Cemployee*(2-pi(x(3,t)));   
        end
        
        Z=[Z1 Z2]';
        sol.ft=ft;
        sol.st=st;
        sol.x=x;
        sol.L=L;
        sol.Ynew=Ynew;
        
end