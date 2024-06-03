function Zad_5
    [lake_volume, x, y, z, zmin] = zadanie5();
end

function [lake_volume, x, y, z, zmin] = zadanie5()
   % Funkcja zadanie5 wyznacza objętość jeziora metodą Monte Carlo.
    %
    %   lake_volume - objętość jeziora wyznaczona metodą Monte Carlo
    %
    %   x - wektor wierszowy, który zawiera współrzędne x wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %
    %   y - wektor wierszowy, który zawiera współrzędne y wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %
    %   z - wektor wierszowy, który zawiera współrzędne z wszystkich punktów
    %       wylosowanych w tej funkcji w celu wyznaczenia obliczanej całki.
    %
    %   zmin - minimalna dopuszczalna wartość współrzędnej z losowanych punktów
    
    % Liczba punktów do wylosowania
    N = 1e6;
    
    % Maksymalne wartości dla x, y i z
    x_max = 100; % [m]
    y_max = 100; % [m]
    z_max = 45;  % [m]
    
    
    x = x_max * rand(1, N); % [m]
    y = y_max * rand(1, N); % [m]
    z = -z_max * rand(1, N); % [m] z zakresu [-45, 0]
    
    
    zmin = -z_max; % minimalna wartość współrzędnej z
    
    
    points_in_lake = 0;
    
    
    for i = 1:N
        lake_depth = get_lake_depth(x(i), y(i));
        if z(i) >= lake_depth
            points_in_lake = points_in_lake + 1;
        end
    end
    
    
    V = x_max * y_max * z_max;
    
    
    lake_volume = (points_in_lake / N) * V;
end