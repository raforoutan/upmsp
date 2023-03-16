function Plotsolution(Archive,it)


        q=[Archive.Z];
        x=q(1,:);
        y=q(2,:);
        plot(x,y,'or','Markersize',5,'markerfacecolor','y');
        title(['Iteration= ',num2str(it)])
        xlabel('f_1(x)');
        ylabel('f_2(x)');
        
end