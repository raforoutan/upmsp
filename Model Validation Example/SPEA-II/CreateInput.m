function Input=CreateInput

alpha={[1,3]
       [1,3]
       [1,2,3]
       1
       [1,2]
       [1,2,3]
       [2,3]
       [2,3]
       3};   %Machine eligibility

lambda1=[1 0
         1 0
         1 0
         0 0
         0 0
         0 0
         0 1
         0 1
         0 0];   %Membership of a batch
    
lambda2=[0
         0
         0
         1
         1
         1
         0
         0
         0];   %Membership of a job family 
     
beta= [1 1.5 2 1 2 1.5 1.5 1 1
       2 2 1 1 1 1 1.5 1 1    
       1 2 1.5 1.5 2 2 1 2 1];   %Speed of machines for each job  

I=numel(beta(:,1));   %Number of machines
J=numel(beta(1,:));   %Number of jobs
B=numel(lambda1(1,:));   %Number of batches
F=numel(lambda2(1,:));   %Number of job families
K=J;   %Number of positions

T=[3 5 6 4 7 6 4 5 1];   %Processing time of jobs
FF=[10 20 15];   %Fixed cost of machines
tau=[3 5 6];   %Variable cost of machines
M=1000000;   %An arbitrary large number
     
Precedency={[]
            1
            []
            3
            4
            []
            []
            [2,5]
            8};   %Precedence constraints

Input.alpha=alpha;
Input.lambda1=lambda1;
Input.lambda2=lambda2;
Input.beta=beta;
Input.I=I;
Input.J=J;
Input.B=B;
Input.F=F;
Input.K=K;
Input.T=T;
Input.FF=FF;
Input.tau=tau;
Input.M=M;
Input.Precedency=Precedency;
%save matlab.mat alpha lambda1 lambda2 beta I J B F K T FF tau M Precedency
end
