clc;
clear;
close all;
tic;
%% Definition problem

Input=load('matlab');
Input=Input.model;
nvar=Input.J;
%% SA parameters

Maxit=70;        %maximume number of iteration
Maxsubit=25;       %maximume number of iteration
T0=150;            % number of temp
alpha=0.93;
Tabulistsize=5;
TabuList=[];
Archive=[];
%% Initialization

sol.position=Randomsolution(Input);
sol.Z=Schedulingcost(sol.position,Input);

sol.N=[];       % number of individuals that dominance 'sol'       

Archive=[Archive sol];
TabuList=[TabuList sol];
% store temp
T=T0;


%% SA Main loop

for it=1:Maxit
    
   for subit1=1:Maxsubit
       
       %  create new solution 
       newsol=CreateNeighbor(sol,TabuList,1,Input);
%        newsol.Z=Schedulingcost(newsol.position,Input);
       Gsol=sum(log(sol.Z));
       Gnewsol=sum(log(newsol.Z));
       P=exp((-1/T) * (Gnewsol - Gsol));
       
       if rand<=P
          sol=newsol;
       end
       Archive=SaveStrategy(sol,Archive);
               
        t=numel(Archive);
        k=randsample(t,1);
%         sol=Archive(end);
        sol=Archive(k);
%             figure(1);
%             Plotsolution(Archive,it);
   end
   
    % Update taboo list   
        if numel(TabuList)==Tabulistsize
           TabuList(end)=[]; 
           TabuList=[sol TabuList];    %#ok
        else
           TabuList=[sol TabuList];        %#ok
        end      
   % update temp
    T=alpha*T;
    
    % show Non-dominated Solutions
    figure(1);
    Plotsolution(Archive,it);
   
end
toc;

% result
disp(['Number of Non-dominated Solutions = ' num2str(numel(Archive))]);






