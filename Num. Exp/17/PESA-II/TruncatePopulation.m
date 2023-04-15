function [pop, grid]=TruncatePopulation(pop,grid,E,beta)

    ToBeDeleted=[];

    for e=1:E
        
        sg=grid([grid.N]>0);

        p=[sg.N].^beta;
        p=p/sum(p);

        k=RouletteWheelSelection(p);

        Members=sg(k).Members;

        i=Members(randi([1 numel(Members)]));

        Members(Members==i)=[];

        grid(sg(k).Index).Members=Members;
        grid(sg(k).Index).N=numel(Members);

        ToBeDeleted=[ToBeDeleted i];
        
    end
    
    pop(ToBeDeleted)=[];
    
end