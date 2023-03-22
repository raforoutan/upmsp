% function PlotCosts(pop)
% 
%     Costs=[pop.Cost];
%     
%     plot(Costs(1,:),Costs(2,:),Costs(3,:),'r*','MarkerSize',8);
%     xlabel('1st Objective');
%     ylabel('2nd Objective');
%     zlabel('3rd Objective');
%     grid on;
% 
% end

function PlotCosts(pop,it)
      
        q=[pop.Cost];
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