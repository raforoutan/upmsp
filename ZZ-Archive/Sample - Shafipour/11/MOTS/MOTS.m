clc;
clear;
close all;
tic;
%% Definition problem

Input=load('matlab');
Input=Input.model;
% nvar=Input.n;


%% TS parameters

Maxit=70;        %maximume number of iteration
Neighborsize=40;
Tabulistsize=4;

Tabulist=[];
Candidatelist=[];
Paretolist=[];

X.position=Randomsolution(Input);

X.Z=Schedulingcost(X.position,Input);

Tabulist=[Tabulist X];
Paretolist=[Paretolist
                X];


%% MOTS Main loop

for it=1:Maxit
    
    % Neighbourhood Generation
    
    pop=CreateNeighbor(X,Input,Tabulist,Neighborsize);
    
    
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
    X=Xnew;
    % Show the Pareto list
  figure(1); 
  Plotsolution(Paretolist,it);  
end
toc;
disp(['Number of Non-dominated Solutions = ' ...
    num2str(numel(Paretolist))]);


