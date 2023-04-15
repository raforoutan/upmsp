function Input=CreateInput

alpha={[2,3,4]
[1,2,3,4]
[1,2,3,4]
[2,4]
[1,2,3,4]
[2,3]
[1,2,3,4]
[1,2,3,4]
[1,2,3,4]
[2,3]
[2,3]
4
[1,2,3,4]
[1,2,3,4]
[1,2,3,4]
[1,2,4]
[1,3,4]
[1,4]
[1,2,3,4]
[2,4]};   %Machine eligibility

lambda1=[0	0
0	0
0	0
0	0
0	0
0	0
0	0
1	0
0	0
0	0
0	0
0	1
0	0
0	0
0	0
0	0
1	0
0	1
0	0
0	0];   %Membership of a batch
    
lambda2=[1
0
0
1
0
0
1
0
0
0
0
0
1
1
0
0
0
0
0
0];   %Membership of a job family 
     
beta= [1.50000000000000	2	1.50000000000000	1.50000000000000	1	1.50000000000000	1.50000000000000	1	2	1	1.50000000000000	2	1.50000000000000	1.50000000000000	2	2	2	1	1	2
1.50000000000000	1.50000000000000	1.50000000000000	2	1.50000000000000	1	1.50000000000000	1.50000000000000	2	1.50000000000000	2	2	1.50000000000000	1.50000000000000	1.50000000000000	1	1.50000000000000	2	1.50000000000000	2
2	1.50000000000000	1.50000000000000	1.50000000000000	2	2	1.50000000000000	2	2	2	2	1	1.50000000000000	1.50000000000000	1.50000000000000	1	1	2	1	2
1	2	1.50000000000000	1	1.50000000000000	1	2	1.50000000000000	1	1	1	1	1.50000000000000	2	1.50000000000000	1.50000000000000	2	1	2	1];   %Speed of machines for each job  

I=numel(beta(:,1));   %Number of machines
J=numel(beta(1,:));   %Number of jobs
B=numel(lambda1(1,:));   %Number of batches
F=numel(lambda2(1,:));   %Number of job families
K=J;   %Number of positions

T=[5	3	5	1	7	7	8	9	5	4	2	5	5	7	2	6	5	3	8	5];   %Processing time of jobs
FF=[10	20	15	9];   %Fixed cost of machines
tau=[2	4	3	2];   %Variable cost of machines
M=1000000;   %An arbitrary large number
     
Precedency={[]
[]
[]
1
[]
[1,5]
[3,6]
4
3
[]
[4,10]
[8,11]
[6,2]
[]
[9,4,1]
[]
[]
[]
[]
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
