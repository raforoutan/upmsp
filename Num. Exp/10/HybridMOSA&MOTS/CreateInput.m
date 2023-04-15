function Input=CreateInput

alpha={[2,3,4,5,6]
[1,2,4,6]
[1,2,3,4,5,6]
[1,2,3,4,5,6]
[3,4,5,6]
[1,4]
[5,6]
[3,6]
[4,5]
[1,2]
[2,4,5,6]
[1,2,3,4,5,6]
[1,2,3]
[2,5,6]
[1,2,3,4,5,6]};   %Machine eligibility

lambda1=[0	0	1
0	0	0
0	0	0
1	0	0
0	0	0
0	0	0
1	0	0
0	0	0
0	0	1
0	0	0
0	0	0
0	0	0
0	1	0
0	0	0
0	1	0];   %Membership of a batch
    
lambda2=[0	0
1	0
0	1
0	0
0	0
0	0
0	0
0	0
0	0
0	1
0	0
0	1
0	0
1	0
0	0];   %Membership of a job family 
     
beta= [1	2	1	1	1.50000000000000	2	1	1	1.50000000000000	1	1.50000000000000	2	1.50000000000000	1	1.50000000000000
1	1.50000000000000	1.50000000000000	2	2	1.50000000000000	2	1	1.50000000000000	2	2	2	1.50000000000000	1.50000000000000	2
1	2	1.50000000000000	2	1.50000000000000	2	2	1	1.50000000000000	2	1.50000000000000	1	1.50000000000000	1.50000000000000	2
1.50000000000000	1.50000000000000	2	2	1	2	2	2	1	1.50000000000000	1.50000000000000	1	1	2	1.50000000000000
1.50000000000000	1.50000000000000	1	1.50000000000000	1.50000000000000	1	2	2	1	2	1	2	1	1.50000000000000	1.50000000000000
2	1.50000000000000	1.50000000000000	2	1.50000000000000	1.50000000000000	2	1	2	1	2	1.50000000000000	2	1.50000000000000	1.50000000000000];   %Speed of machines for each job  

I=numel(beta(:,1));   %Number of machines
J=numel(beta(1,:));   %Number of jobs
B=numel(lambda1(1,:));   %Number of batches
F=numel(lambda2(1,:));   %Number of job families
K=J;   %Number of positions

T=[7	1	2	9	6	3	5	3	4	4	4	3	4	3	8];   %Processing time of jobs
FF=[9	20	10	10	9	15];   %Fixed cost of machines
tau=[2	4	2	2	2	3];   %Variable cost of machines
M=1000000;   %An arbitrary large number
     
Precedency={[]
[]
[]
[]
2
[]
[]
[]
[2,1,6]
[]
[]
[4,11]
[8,12,6,9,5,1,4]
[10,7,5]
[]};   %Precedence constraints

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
