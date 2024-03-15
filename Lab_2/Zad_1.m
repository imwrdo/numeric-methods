function Zad_1

n_max = 200;
a = 10;
r_max = a/2;
[circles, index_number] = generate_circles(a, r_max, n_max);
plot_circles(a, circles, index_number); 
print -dpng zadanie1.png 
end

function [circles, index_number] = generate_circles(a, r_max, n_max)
index_number = 201267;
L1 = mod(index_number,10);
if mod(L1, 2) == 0 
        circles = zeros(n_max, 3);
    else 
        circles = zeros(3, n_max);
end
counter = 1;
while counter <= n_max
    radius = r_max * rand();
    x_coordinate = (a - 2*radius) * rand()+radius;
    y_coordinate = (a - 2*radius) * rand()+radius;
    intersects = true;
    for i = 1:counter-1
        if mod(L1,2) == 0
            dist = sqrt((circles(i,1)- x_coordinate)^2 + (circles(i,2)-y_coordinate)^2);
            if dist <= (circles(3,i)+radius) || radius <= 0 || radius > r_max
                intersects = false;
                break;
            end
        else
            dist = sqrt((circles(2,i)- x_coordinate)*(circles(2,i)- x_coordinate) + (circles(3,i)-y_coordinate)*(circles(3,i)-y_coordinate));
            if dist < (circles(1,i)+radius) || radius <= 0 || radius > r_max
                intersects = false;
                break;
            end
        end
    end
    if intersects
        
        if mod(L1,2)==0
            circles(counter,:) = [x_coordinate,y_coordinate,radius];
        else
            circles(:,counter) = [radius,x_coordinate,y_coordinate];

        end
        counter = counter + 1;
    end
end
end