function Input=CreateInput

alpha={[1,2,3,4,5,6]
[2,3,4,5]
[2,3]
[1,4,5,6]
4
[1,2,3,4,5,6]
[3,4,6]
[2,4,5,6]
[2,3,4,6]
[1,2,3,5,6]
[2,3,4]
2
[1,5,6]
3
[1,2,3,4,6]
[2,5]
[1,2,3,4,5,6]
[1,2,3,5,6]
[1,2,3,4,5,6]
[1,2,4,5]
[2,5]
[2,6]
[1,2,3,4,6]
[1,2,3,4,5,6]
[2,3,5]
[1,2,3,5,6]
5
[1,2,4,6]
[2,5,6]
[1,2,3,4,6]};   %Machine eligibility

lambda1=[0	0	1
0	0	0
1	0	0
0	0	1
0	1	0
0	0	0
0	0	0
0	0	1
0	0	0
0	0	0
0	0	0
0	0	0
0	0	0
0	0	0
0	1	0
0	0	0
0	0	0
0	0	0
1	0	0
0	0	0
0	0	0
0	0	0
1	0	0
0	0	0
0	0	0
0	0	0
0	0	1
0	0	0
0	0	0
0	1	0];   %Membership of a batch
    
lambda2=[0	0
0	1
0	0
0	0
0	0
0	0
0	1
0	0
0	1
0	0
0	0
1	0
0	0
0	1
0	0
1	0
0	0
1	0
0	0
1	0
0	0
1	0
0	0
0	0
0	0
0	0
0	0
0	0
1	0
0	0];   %Membership of a job family 
     
beta= [2	1.50000000000000	1	2	1.50000000000000	1	1	1.50000000000000	1.50000000000000	2	1	1.50000000000000	1	2	1.50000000000000	1	1	2	1.50000000000000	1.50000000000000	2	2	2	1	1.50000000000000	2	1.50000000000000	2	2	2
1	1	1.50000000000000	1	1.50000000000000	2	1	1.50000000000000	1.50000000000000	2	2	1.50000000000000	1.50000000000000	2	2	2	2	1.50000000000000	2	1.50000000000000	2	1.50000000000000	2	2	1.50000000000000	1.50000000000000	1	1	1	1.50000000000000
1	1.50000000000000	2	1.50000000000000	1.50000000000000	2	1	1.50000000000000	1.50000000000000	1.50000000000000	1.50000000000000	2	1	2	2	1	1	1.50000000000000	2	1.50000000000000	1	1.50000000000000	1.50000000000000	1.50000000000000	1	2	1.50000000000000	1.50000000000000	1	1.50000000000000
1	1	2	1.50000000000000	1	1.50000000000000	2	1	2	1	1	1	2	1	2	1	1	2	1	1.50000000000000	2	2	2	2	1.50000000000000	1	1.50000000000000	1	2	1.50000000000000
2	2	1.50000000000000	1	2	2	2	2	2	1.50000000000000	2	1.50000000000000	2	1	2	1	1.50000000000000	1.50000000000000	1	2	1.50000000000000	2	1.50000000000000	2	1.50000000000000	2	2	1.50000000000000	2	1.50000000000000
2	1	2	1	1	2	2	2	1	2	1.50000000000000	1.50000000000000	2	2	1	2	1	1.50000000000000	1	2	2	1.50000000000000	2	2	2	1.50000000000000	1.50000000000000	1.50000000000000	1.50000000000000	1.50000000000000];   %Speed of machines for each job  

I=numel(beta(:,1));   %Number of machines
J=numel(beta(1,:));   %Number of jobs
B=numel(lambda1(1,:));   %Number of batches
F=numel(lambda2(1,:));   %Number of job families
K=J;   %Number of positions

T=[4	5	5	8	3	4	5	5	4	5	7	2	5	2	5	5	7	3	5	5	7	6	4	4	4	8	4	3	4	6];   %Processing time of jobs
FF=[15	15	9	9	20	10];   %Fixed cost of machines
tau=[3	3	2	2	4	2];   %Variable cost of machines
M=1000000;   %An arbitrary large number
     
Precedency={[]
[]
[]
[]
3
[]
[]
6
[7,4,3]
[]
[]
11
[2,10]
[]
[]
[]
[]
[15,7,14,17]
[]
[]
[]
[7,3,2,8,20,18]
[]
[1,13,16,19,4,21]
[2,17,22,14,19,7,20,11,4]
[11,8,7,20,17]
[]
[]
[12,7,26,25,9,18,22,27,10,4,21,2,5]
11};   %Precedence constraints

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
