function plot_circles(a,circles,index_number)
L1 = mod(index_number,10);
figure;
axis equal;
axis([0 a 0 a]);
hold on;
if mod(L1,2)==0
    for i = 1:size(circles,1)
    x_coordinate = circles(i,1);
    y_coordinate = circles(i,2);
    radius = circles(i,3);
    plot_circle(radius,x_coordinate,y_coordinate);
    end
else
    for i = 1:size(circles,2)
    x_coordinate = circles(2,i);
    y_coordinate = circles(3,i);
    radius = circles(1,i);
    plot_circle(radius,x_coordinate,y_coordinate);
    end
end

hold off;
end