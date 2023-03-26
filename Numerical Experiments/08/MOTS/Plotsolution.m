function Plotsolution(Pareto,it)


%         q=[Pareto.cost];
%         x=q(1,:);
%         y=q(2,:);
%         plot(x,y,'or','Markersize',5,'markerfacecolor','y');
%         title(['Iteration =' num2str(it)]);
%         xlabel('f_1(x)');
%         ylabel('f_2(x)');   
      
        q=[Pareto.cost];
        x=q(1,:);
        y=q(2,:);
        z=q(3,:);
        plot3(x,y,z,'or','Markersize',5,'markerfacecolor','y');
        title(['Iteration =' num2str(it)]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
        zlabel('f_3(x)');
        grid on


end