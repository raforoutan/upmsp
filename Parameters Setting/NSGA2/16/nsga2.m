clc;
clear;
close all;
tic;
%% Problem Definition

%Input=load('matlab');

Input=CreateInput;
[Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);

%% NSGA-II Parameters

MaxIt=180;      % Maximum Number of Iterations

nPop=100;        % Population Size

pCrossover=0.6;                         % Crossover Percentage
nCrossover=2*round(pCrossover*nPop/2);  % Number of Parnets (Offsprings)

pMutation=0.4;                          % Mutation Percentage
nMutation=round(pMutation*nPop);        % Number of Mutants

mu=0.02;                    % Mutation Rate

% sigma=0.1*(VarMax-VarMin);  % Mutation Step Size


%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.Rank=[];
empty_individual.DominationSet=[];
empty_individual.DominatedCount=[];
empty_individual.CrowdingDistance=[];

pop=repmat(empty_individual,nPop,1);

for i=1:nPop

    [Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
    CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);
    pop(i).Position=Ynew;
    pop(i).Cost=CostFunction(pop(i).Position);
    
end

% x.position=Ynew;
% x.cost=CostFunction(x.position);


% Non-Dominated Sorting
[pop, F]=NonDominatedSorting(pop);

% Calculate Crowding Distance
pop=CalcCrowdingDistance(pop,F);

% Sort Population
[pop, F]=SortPopulation(pop);


%% NSGA-II Main Loop

for it=1:MaxIt
    
    % Crossover
    popc=repmat(empty_individual,nCrossover/2,2);
    for k=1:nCrossover/2
        
        i1=randi([1 nPop]);
        p1=pop(i1);
        
        i2=randi([1 nPop]);
        p2=pop(i2);
        
        [popc(k,1).Position , popc(k,2).Position]=Crossover(p1.Position,p2.Position);
        
%         [Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
%         CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);
%       
    
        popc(k,1).Cost=SchedulingCost(popc(k,1).Position,NewPrecedency,Input);
        popc(k,2).Cost=SchedulingCost(popc(k,2).Position,NewPrecedency,Input);
    
        
%         popc(k,1).Cost=CostFunction(popc(k,1).Position);
%         popc(k,2).Cost=CostFunction(popc(k,2).Position);
        
    end
    popc=popc(:);
    
    % Mutation
    popm=repmat(empty_individual,nMutation,1);
    for k=1:nMutation
        
        i=randi([1 nPop]);
        p=pop(i);
        
%         popm(k).Position=Mutate(p.Position,mu,sigma);
        popm(k).Position=Mutate(p.Position);
        popm(k).Cost=SchedulingCost(popm(k).Position,NewPrecedency,Input);
      % popm(k).Cost=CostFunction(popm(k).Position);
        
    end
    
    % Merge
    pop=[pop
         popc
         popm];
     
    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);

    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);

    % Sort Population
    [pop, F]=SortPopulation(pop);
    
    % Truncate
    pop=pop(1:nPop);
    
    % Non-Dominated Sorting
    [pop, F]=NonDominatedSorting(pop);

    % Calculate Crowding Distance
    pop=CalcCrowdingDistance(pop,F);

    % Sort Population
    [pop, F]=SortPopulation(pop);
    
    % Store F1
    F1=pop(F{1});
    
    % Show Iteration Information
    % disp(['Iteration ' num2str(it) ': Number of F1 Members = ' num2str(numel(F1))]);
    
    % Plot F1 Costs
%     figure(1);
%     PlotCosts(F1);
    
    figure(1);
    PlotCosts(F1,it);
    
end
time=toc;

%disp(['Iteration ' num2str(it) ': Number of F1 Members = ' num2str(numel(F1))]);   %Moved from line 138 to here.


Output=CreateOutput(F1);
Output.Time=time;
save('nsga2' , 'Output');

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
disp(['RAS2 = ' ...
    num2str(Output.RAS2)]);



%% Results

