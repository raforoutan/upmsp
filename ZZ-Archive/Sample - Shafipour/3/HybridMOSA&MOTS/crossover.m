function [y1,y2]=crossover(x1,x2)

    METHOD=randi([1,2]);
    
    switch METHOD
        
        case 1
            
            [y1,y2]=singlepointcrossover(x1,x2);
            
        case 2
            
            [y1,y2]=doublepointcrossover(x1,x2);
    end 
end