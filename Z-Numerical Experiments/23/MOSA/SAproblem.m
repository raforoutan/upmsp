clc;
clear;
close all;
tic;
%% Definition problem

%Input=load('matlab.mat');

Input=CreateInput;
[Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);

%% SA parameters

Maxit=200;        %maximume number of iteration
Maxsubit=25;       %maximume number of iteration
T0=100;            % number of temp
alpha=0.93;

%% Initialization

Archive=[];

x.position=Ynew;
x.cost=CostFunction(x.position);
%sol.position=Randomsolution(Input);
%sol.Z=Schedulingcost(sol.position,Input);

x.N=[];       % number of individuals that dominance 'sol'       

Archive=[Archive x];
% store temp
T=T0;


%% SA Main loop

for it=1:Maxit
    
   for subit1=1:Maxsubit
       
       %  create new solution
       [Ynew , NewPrecedency]=RepairSolution(Mutation(x.position),Input);
       newsol.position=Ynew;
       newsol.cost=SchedulingCost(newsol.position,NewPrecedency,Input); 
       Gsol=sum(log(x.cost));
       Gnewsol=sum(log(newsol.cost));
       P=exp((-1/T) * (Gnewsol - Gsol));
       
       if rand<=P
          x=newsol;
       end
       Archive=SaveStrategy(x,Archive);
               
        t=numel(Archive);
        k=randsample(t,1);
        x=Archive(k);
%             figure(1);
%             Plotsolution(Archive,it);
   end
      
   % update temp
    T=alpha*T;
    
    % show Non-dominated Solutions
    figure(1);
    Plotsolution(Archive,it);
end
time=toc;

% result
%disp(['Number of Non-dominated Solutions = ' num2str(numel(Archive))]);


Output=CreateOutput(Archive);
Output.Time=time;
save('mosa' , 'Output');

disp(['Time = ' ...
    num2str(Output.Time)]);
disp(['NPS = ' ...
    num2str(Output.NPS)]);
disp(['MID = ' ...
    num2str(Output.MID)]);
disp(['DM = ' ...
    num2str(Output.DM)]);
disp(['SNS = ' ...
    num2str(Output.SNS)]);
disp(['RAS = ' ...
    num2str(Output.RAS)]);



