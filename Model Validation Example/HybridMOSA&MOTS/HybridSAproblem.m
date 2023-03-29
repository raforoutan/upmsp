clc;
clear;
close all;
tic;
%% Definition problem

Input=CreateInput;
[Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);
%% SA parameters

Maxit=50;        %maximume number of iteration
Maxsubit=25;       %maximume number of iteration
T0=130;            % number of temp
alpha=0.93;
Tabulistsize=5;
%Neighborsize=40;

%% Initialization

TabuList=[];
Archive=[];

x.position=Ynew;
x.cost=CostFunction(x.position);

x.N=[];       % number of individuals that dominance 'x'       

Archive=[Archive x];
TabuList=[TabuList x];
% store temp
T=T0;


%% Hybrid Main loop

for it=1:Maxit
    
   for subit1=1:Maxsubit
       
       %  create new solution 
       newsol=CreateNeighbor(x,TabuList,1,Input);
%        newsol.Z=Schedulingcost(newsol.position,Input);
       Gsol=sum(log(x.cost));
       Gnewsol=sum(log(newsol.cost));
       P=exp((-1/T) * (Gnewsol - Gsol));
       
       if rand<=P
          x=newsol;
       end
       Archive=SaveStrategy(x,Archive);
               
        t=numel(Archive);
        k=randsample(t,1);
%         sol=Archive(end);
        x=Archive(k);
%             figure(1);
%             Plotsolution(Archive,it);
   end
   
    % Update taboo list   
        if numel(TabuList)==Tabulistsize
           TabuList(end)=[]; 
           TabuList=[x TabuList];    %#ok
        else
           TabuList=[x TabuList];        %#ok
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
save('hybrid' , 'Output');

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



