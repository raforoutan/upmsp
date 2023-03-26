
function PlotCosts(EP,it)

        EPC=[EP.Cost];
        figure(1);
        plot3(EPC(1,:),EPC(2,:),EPC(3,:),'or','Markersize',5,'markerfacecolor','y');
        title(['Iteration =' num2str(it)]);
        xlabel('f_1(x)');
        ylabel('f_2(x)'); 
        zlabel('f_3(x)');
        grid on

end