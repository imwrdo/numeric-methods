function Zad_4
r_max = 2;
n_max = 200;
a = 10 ; 
[circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max);
end

function [circles, index_number,circle_areas,rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
index_number = 201267;
L1 = mod(index_number,10);
if mod(L1, 2) == 0 
        circles = zeros(n_max, 3);
    else 
        circles = zeros(3, n_max);
end

rand_counts = zeros(n_max, 1); 
counts_mean = zeros(n_max, 1); 
counter = 1;
while counter <= n_max
    radius = r_max * rand();
    x_coordinate = (a - 2*radius) * rand()+radius;
    y_coordinate = (a - 2*radius) * rand()+radius;
    intersects = true;
    rand_count = 0; 
    for i = 1:counter-1
        rand_count = rand_count + 1; 
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
        rand_counts(counter) = max(rand_count, 1);
        if mod(L1,2)==0
            circles(counter,:) = [x_coordinate,y_coordinate,radius];
        else
            circles(:,counter) = [radius,x_coordinate,y_coordinate];

        end
        counter = counter + 1;
    end
end
R = circles(1,:);
circle_areas = pi* R.^2;
circle_areas = cumsum(circle_areas);

counts_mean(1) = rand_counts(1); 
for i = 2:n_max
    counts_mean(i) = mean(rand_counts(1:i)); 
end 
end
