clc;
clear;
close all;
tic;
%% Definition problem

%Input=load('matlab.mat');

Input=CreateInput;
[Ynew , NewPrecedency]=RepairSolution(RandomSolution(Input),Input);
CostFunction=@(x) SchedulingCost(Ynew,NewPrecedency,Input);

%% TS parameters

Maxit=70;        %maximume number of iteration
Neighborsize=40;
Tabulistsize=4;

%% Initialization
Tabulist=[];
Candidatelist=[];
Paretolist=[];

x.position=Ynew;
x.cost=CostFunction(x.position);

Tabulist=[Tabulist x];
Paretolist=[Paretolist x];

%% MOTS Main loop

for it=1:Maxit
    
    % Neighbourhood Generation
    
    pop=CreateNeighbor(x,Input,Tabulist,Neighborsize);
    
    
    % Identify Candidate Solutions

    [newCandidatelist,Updatelist]=CandidateSolutions(pop,Paretolist,Candidatelist);
    Paretolist=Updatelist.P;
    Candidatelist=Updatelist.C;
    % Selection of new seed solution
    n=numel(newCandidatelist);
    if n==0
          if numel(Candidatelist)==0
              break;
          end        
        Xnew=Candidatelist(1);
        
    % Update Pareto list
        Paretolist=[Paretolist
                        Xnew];  %#ok
        
     % Update taboo list   
        if numel(Tabulist)==Tabulistsize
           Tabulist(end)=[]; 
           Tabulist=[Xnew Tabulist];    %#ok
        else
           Tabulist=[Xnew Tabulist];        %#ok
        end
     % Update candidate list
        Candidatelist=Candidatelist(2:end);
        
    else
        
        t=randi(n);
        Xnew=newCandidatelist(t);
     % Update Pareto list
        Paretolist=[Paretolist
                        Xnew]; %#ok
        % Update taboo
        if numel(Tabulist)==Tabulistsize
           Tabulist(end)=[]; 
           Tabulist=[Xnew Tabulist];        %#ok
        else
           Tabulist=[Xnew Tabulist];        %#ok
        end
       % Update candidate list
       Candidatelist=[Candidatelist
                      newCandidatelist];    %#ok
          if numel(Candidatelist)==0
              break;
          end
    end
    x=Xnew;
    % Show the Pareto list
  figure(1); 
  Plotsolution(Paretolist,it);  
end
time=toc;

%disp(['Number of Non-dominated Solutions = ' ...
    %num2str(numel(Paretolist))]);

Output=CreateOutput(Paretolist);
Output.Time=time;
save('mots' , 'Output');

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

