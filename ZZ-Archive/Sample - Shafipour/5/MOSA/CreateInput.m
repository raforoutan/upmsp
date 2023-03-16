function Input=CreateInput


      P=[4 3
         2 5
         1 8
         5 2
         3 5
         5 3
         6 5
         4 3];      % created randomly in []
      
      J=numel(P(:,1));   % number of Jobs
      M=numel(P(1,:));   % number of Machines
        
      Eligible={ [1,2]
                 [1 2]
                  2            % Eligibility Constraint for each Jobs
                  1
                 [1 2]
                 [1 2]
                 [1 2]
                 [1 2]}; 
      Precedence={[],[],1,[2,3],[],4,[],[]};       
      D=[7 10 13 15 10 12 15 13 16 11];          % Due dates
      
      pi=[1.45 1.15];           % The skill level of workers
      
      K=numel(pi);              % number of workers
      
      S1(:,:,1)=[ 4  3  2  3  5  4  4  3  5  3
                  2  4  3  5  2  3  1  1  2  1
                  2  1  5  1  2  2  2  4  5  4
                  4  3  5  4  2  2  1  3  5  1
                  3  2  2  4  3  4  5  1  3  1
                  3  1  4  2  3  1  1  5  4  4
                  2  3  2  2  5  1  1  3  4  3
                  5  4  4  1  3  1  3  2  5  5];      % set up times
              
      S1(:,:,2)=[ 2  3  4  5  3  3  5  3  4  4
                  3  1  3  1  3  5  3  1  4  3
                  5  4  1  4  3  4  2  4  1  4
                  2  4  4  1  1  4  5  2  4  1
                  1  1  2  2  5  1  4  2  3  2
                  5  5  3  2  5  1  3  1  5  4
                  5  1  2  1  1  3  5  1  4  2
                  4  3  5  2  5  4  5  1  3  1];
      
      S(:,:,1,1)=pi(1,1).*S1(:,:,1);
      S(:,:,2,1)=pi(1,1).*S1(:,:,2);            % Set up times dependent workers
      S(:,:,1,2)=pi(1,2).*S1(:,:,1);        
      S(:,:,2,2)=pi(1,2).*S1(:,:,2);
            
      Cemployee=500;      

      Input.P=P;
      Input.M=M;
      Input.J=J;
      Input.Eligible=Eligible;
      Input.D=D;
      Input.pi=pi;
      Input.S=S;
      Input.K=K;
      Input.C=Cemployee;
      Input.Precedence=Precedence;
end