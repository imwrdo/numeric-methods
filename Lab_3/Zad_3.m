function Zad_3
    N = 100;
    [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N);
end

function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N)
% A - macierz z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% M - macierz pomocnicza opisana w instrukcji do Laboratorium 3 – sprawdź wzór (5) w instrukcji, który definiuje M jako M_J.
% bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3 – sprawdź wzór (5) w instrukcji, który definiuje bm jako b_{mJ}.
% x - rozwiązanie równania macierzowego
% err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b)
% time - czas wyznaczenia rozwiązania x
% iterations - liczba iteracji wykonana w procesie iteracyjnym metody Jacobiego
% index_number - Twój numer indeksu

index_number = 201267; % Tutaj wprowadź swój numer indeksu
L1 = mod(index_number, 10);

[A,b] = generate_matrix(N, L1);

% Inicjalizacja x na wektor jedynkowy
x = ones(N, 1);

% Obliczenie macierzy M i wektora bm zgodnie z instrukcją
D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);
M = -D \ (L + U);
bm = D \ b;

% Pomiar czasu
tic;

% Iteracyjne obliczanie przybliżonego rozwiązania x
max_iterations = 1000; % Maksymalna liczba iteracji
tolerance = 1e-12; % Tolerancja dla normy błędu rezydualnego
for iterations = 1:max_iterations
    x_old = x;
    x = M * x_old + bm;
    err_norm = norm(A*x-b);
    if err_norm < tolerance
        break;
    end
end

time = toc;

end