function Input=CreateInput

alpha={[1,3]
[1,2,3,4]
[3,4]
[1,2]
[3,4]
1
1
[1,3,4]
[1,2]
[1,2,3,4]
[1,2,3,4]
[1,2,3,4]
[3,4]
[2,4]
3
[1,3,4]
[1,2,3,4]
[1,4]
[2,4]
[1,3,4]
[1,2,3,4]
[1,4]
[2,3,4]
[1,3,4]
[1,2]};   %Machine eligibility

lambda1=[0	0
0	1
0	1
0	0
0	1
0	0
0	0
0	1
0	0
0	0
0	0
0	0
1	0
1	0
0	0
0	0
0	0
0	0
0	0
0	0
0	0
0	0
0	0
0	0
0	0];   %Membership of a batch
    
lambda2=[1
0
0
1
0
1
1
0
1
1
0
0
0
0
0
1
0
1
0
0
0
1
0
1
0];   %Membership of a job family 
     
beta= [2	1.50000000000000	1	2	1	1	1.50000000000000	1	1	1.50000000000000	1.50000000000000	1.50000000000000	1.50000000000000	1	1	1	1	2	1	2	2	2	2	1	1
1.50000000000000	1	2	2	1.50000000000000	1	2	1	1.50000000000000	1.50000000000000	1.50000000000000	2	2	2	1	1.50000000000000	1	2	1.50000000000000	2	2	2	1.50000000000000	1	1.50000000000000
1	1	1	1	2	2	1.50000000000000	1.50000000000000	2	1.50000000000000	2	2	1.50000000000000	1.50000000000000	1.50000000000000	1.50000000000000	2	2	1	2	1	1.50000000000000	2	2	1.50000000000000
2	2	1	1	1	1.50000000000000	1	2	1	1.50000000000000	1	2	1	1.50000000000000	2	1.50000000000000	1	1	1.50000000000000	1.50000000000000	1	2	2	2	1.50000000000000];   %Speed of machines for each job  

I=numel(beta(:,1));   %Number of machines
J=numel(beta(1,:));   %Number of jobs
B=numel(lambda1(1,:));   %Number of batches
F=numel(lambda2(1,:));   %Number of job families
K=J;   %Number of positions

T=[8	1	6	7	3	8	7	7	5	7	4	3	4	5	7	4	5	7	6	9	3	7	6	4	5];   %Processing time of jobs
FF=[9	15	15	10];   %Fixed cost of machines
tau=[2	3	3	2];   %Variable cost of machines
M=1000000;   %An arbitrary large number
     
Precedency={[]
[]
[]
[]
[]
[]
[]
[]
[]
[]
[]
[5,11,10,2,1]
[10,5,11]
[1,13]
[2,9,6,4,10,8]
[]
[]
16
[2,8,9,12]
[19,14]
[19,3]
[21,2,12,8,16,6,15,17]
[]
[]
[15,11]};   %Precedence constraints

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
