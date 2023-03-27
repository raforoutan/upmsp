function PlotCosts(pop,it)
      
        q=[pop.Cost];
        x=q(1,:);
        y=q(2,:);
        z=q(3,:);
        plot3(x,y,z,'or','Markersize',6, 'marker' , '*' ,'markerfacecolor','green' , 'markeredgecolor','black');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
        zlabel('f_3(x)');
        grid on
        hold on
        qq=[pop.C2];
        x=qq(1,:);
        y=qq(2,:);
        z=qq(3,:);
        plot3(x,y,z,'or','Markersize',6,'markerfacecolor','blue');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
        zlabel('f_3(x)');
        grid on
        hold on
        qqq=[pop.CC];
        x=qqq(1,:);
        y=qqq(2,:);
        z=qqq(3,:);
        plot3(x,y,z,'or','Markersize',6, 'marker' , '+' ,'markerfacecolor','green' , 'markeredgecolor','blue');
        title(['Iteration =' 100]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
        zlabel('f_3(x)');
        grid on
        hold off
        
end