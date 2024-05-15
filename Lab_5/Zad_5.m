function Zad_5
[M,N,P,R,x_coarse,y_coarse,F_coarse,x_fine,y_fine,F_fine] = zadanie5();
end

function [M,N,P,R,x_coarse,y_coarse,F_coarse,x_fine,y_fine,F_fine] = zadanie5()
P = randi([10, 200]); % liczba unikalnych współrzędnych x punktów dla których będzie obliczana interpolacja
R = randi([10, 200]); % liczba unikalnych współrzędnych y punktów dla których będzie obliczana interpolacja
M = randi([4, 40]); % liczba węzłów interpolacji wzdłuż osi X (stopień wielomianu zmiennej x: M-1)
N = randi([4, 40]); % liczba węzłów interpolacji wzdłuż osi Y (stopień wielomianu zmiennej y: N-1)

% Generowanie węzłów interpolacji na płaszczyźnie
x_coarse = linspace(0, 1, M);
y_coarse = linspace(0, 1, N);
[X_coarse, Y_coarse] = meshgrid(x_coarse, y_coarse);

% Wyznaczenie wartości funkcji oryginalnej w węzłach
F_coarse = sin(X_coarse*2*pi) .* abs(Y_coarse-0.5);

MN = M*N;
xvec_coarse = reshape(X_coarse, MN, 1);
yvec_coarse = reshape(Y_coarse, MN, 1);
fvec_coarse = reshape(F_coarse, MN, 1);

% Macierz Vandermonde'a dla interpolacji 2d
V = zeros(MN, MN);

% Obliczanie wartości funkcji interpolującej na gęstszej siatce
x_fine = linspace(0, 1, P);
y_fine = linspace(0, 1, R);
[X_fine, Y_fine] = meshgrid(x_fine, y_fine);

F_fine = zeros(size(X_fine));

% Warunek dotyczący maksymalnej wartości bezwzględnej elementów macierzy F_fine
while max(abs(F_fine),[],'all') <= 100
    % Zaktualizuj M, N, P, R
    M = randi([4, 40]);
    N = randi([4, 40]);
    P = randi([10, 200]);
    R = randi([10, 200]);
    
    % Zaktualizuj węzły interpolacji na płaszczyźnie
    x_coarse = linspace(0, 1, M);
    y_coarse = linspace(0, 1, N);
    [X_coarse, Y_coarse] = meshgrid(x_coarse, y_coarse);
    
    % Wyznacz wartości funkcji oryginalnej w węzłach
    F_coarse = sin(X_coarse*2*pi) .* abs(Y_coarse-0.5);
    
    MN = M*N;
    xvec_coarse = reshape(X_coarse, MN, 1);
    yvec_coarse = reshape(Y_coarse, MN, 1);
    fvec_coarse = reshape(F_coarse, MN, 1);
    
    % Macierz Vandermonde'a dla interpolacji 2d
    V = zeros(MN, MN);
    for i = 0:(M-1)
        for j = 0:(N-1)
            V(:, i*N + j + 1) = xvec_coarse.^i .* yvec_coarse.^j;
        end
    end
    
    % Współczynniki wielomianu interpolacyjnego
    coeffs = V \ fvec_coarse;
    
    % Obliczanie wartości funkcji interpolującej na gęstszej siatce
    x_fine = linspace(0, 1, P);
    y_fine = linspace(0, 1, R);
    [X_fine, Y_fine] = meshgrid(x_fine, y_fine);
    
    F_fine = zeros(size(X_fine));
    % Obliczanie wartości wielomianu interpolującego
    for i = 0:(M-1)
        for j = 0:(N-1)
            F_fine = F_fine + coeffs(i*N + j + 1) * X_fine.^i .* Y_fine.^j;
        end
    end
end

% Wykresy

subplot(2,1,1);
surf(X_coarse, Y_coarse, F_coarse);
title('Funkcja oryginalna');
xlabel('x');
ylabel('y');
zlabel('F(x, y)');


subplot(2,1,2);
surf(X_fine, Y_fine, F_fine);
title('Interpolacja');
xlabel('x');
ylabel('y');
zlabel('F(x, y)');

% Zapisz wykresy do pliku
saveas(gcf, 'zadanie5.png');

end

