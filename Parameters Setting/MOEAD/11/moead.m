clc;
clear;
close all;
tic;

%% Problem Definition

Input=CreateInput;
[Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);
nObj=3;

%% MOEA/D Settings

MaxIt=100;  % Maximum Number of Iterations

nPop=80;    % Population Size (Number of Sub-Problems)

nArchive=90;

% T=max(ceil(0.2*nPop),2);    % Number of Neighbors
T=20;

%% Initialization

% Create Sub-problems
sp=CreateSubProblems(nObj,nPop,T);

% Empty Individual
empty_individual.Position=[];
empty_individual.Cost=[];
empty_individual.g=[];
empty_individual.IsDominated=[];

% Initialize Goal Point
%z=inf(nObj,1);
z=zeros(nObj,1);

% Create Initial Population
pop=repmat(empty_individual,nPop,1);

for i=1:nPop
    [Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
    CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);
    pop(i).Position=Ynew;
    pop(i).Cost=CostFunction(pop(i).Position);
    z=min(z,pop(i).Cost);
end

for i=1:nPop
    pop(i).g=DecomposedCost(pop(i),z,sp(i).lambda);
end

% Determine Population Domination Status
pop=DetermineDomination(pop);

% Initialize Estimated Pareto Front
EP=pop(~[pop.IsDominated]);

%% Main Loop

for it=1:MaxIt
    for i=1:nPop
        
        % Reproduction (Crossover)
        K=randsample(T,2);
        
        j1=sp(i).Neighbors(K(1));
        p1=pop(j1);
        
        j2=sp(i).Neighbors(K(2));
        p2=pop(j2);
        
        y=empty_individual;
        y.Position=Crossover(p1.Position,p2.Position);
        
        y.Cost=CostFunction(y.Position);
        
        z=min(z,y.Cost);
        
        for j=sp(i).Neighbors
            y.g=DecomposedCost(y,z,sp(j).lambda);
            if y.g<=pop(j).g
                pop(j)=y;
            end
        end
        
    end
    
    % Determine Population Domination Status
	pop=DetermineDomination(pop);
    
    ndpop=pop(~[pop.IsDominated]);
    
    EP=[EP
        ndpop];
    
    EP=DetermineDomination(EP);
    EP=EP(~[EP.IsDominated]);
    
    if numel(EP)>nArchive
        Extra=numel(EP)-nArchive;
        ToBeDeleted=randsample(numel(EP),Extra);
        EP(ToBeDeleted)=[];
    end
    
    % Plot EP
    figure(1);
    PlotCosts(EP,it);
    
%     % Display Iteration Information
%     disp(['Iteration ' num2str(it) ': Number of Pareto Solutions = ' num2str(numel(EP))]);
    
end
time=toc;


%% Reults

Output=CreateOutput(EP);
Output.Time=time;
save('moead' , 'Output');

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


