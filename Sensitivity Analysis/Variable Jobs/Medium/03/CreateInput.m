function Input=CreateInput

alpha={[3,4,5]
[1,5]
[3,5]
[3,4,5]
[2,3,5]
[3,4,5]
[1,2,5]
[1,2,3,4,5]
[1,2,3,5]
[1,2,3,5]
[2,3,5]
[2,5]
[1,5]
[1,2,3,4,5]
[1,2,3,5]
[1,2,3,5]
[1,2,3,5]};   %Machine eligibility

lambda1=[0	0
0	1
0	0
0	0
0	0
0	0
1	0
0	1
0	0
0	0
1	0
1	0
0	0
0	0
0	0
0	0
0   0];   %Membership of a batch
    
lambda2=[1
0
1
1
0
0
0
0
0
0
0
0
0
0
0
0
0];   %Membership of a job family 
     
beta= [1	1	1	1.50000000000000	2	2	1.50000000000000	1	2	2	2	2	1	2	1.50000000000000 1.5 1.5
1	1	2	1	1	1.50000000000000	2	1.50000000000000	2	1	2	1.50000000000000	2	1	2  2  2
2	1	1.50000000000000	1	1.50000000000000	1.50000000000000	1.50000000000000	1	1	1	2	1.50000000000000	2	1	2   2  2
2	1.50000000000000	1.50000000000000	1	2	1	1	2	2	2	1.50000000000000	1.50000000000000	1.50000000000000	2	1   1  1
2	1.50000000000000	1.50000000000000	1	2	1	1	2	2	2	1.50000000000000	1.50000000000000	1.50000000000000	2	1   1  1];   %Speed of machines for each job  

I=numel(beta(:,1));   %Number of machines
J=numel(beta(1,:));   %Number of jobs
B=numel(lambda1(1,:));   %Number of batches
F=numel(lambda2(1,:));   %Number of job families
K=J;   %Number of positions

T=[7	7	7	5	6	8	5	2	7	6	4	9	3	6	6   5   5];   %Processing time of jobs
FF=[10	10	10	10  10];   %Fixed cost of machines
tau=[2	2	2	2  2];   %Variable cost of machines
M=1000000;   %An arbitrary large number
     
Precedency={[]
1
[]
[]
[]
[]
[]
[1,5]
[]
9
[9,7]
[]
4
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
