function Lab_5
N = 1000:1000:8000;
n = length(N);
time_Jacobi = zeros(1, n);
time_Gauss_Seidel = zeros(1, n);
iterations_Jacobi = zeros(1, n);
iterations_Gauss_Seidel = zeros(1, n);

for i = 1:n
    [ ~, ~, ~, ~, ~, ~, time_Jacobi(i), iterations_Jacobi(i) ] = solve_Jacobi(N(i));
    [ ~, ~, ~, ~, ~, ~, time_Gauss_Seidel(i), iterations_Gauss_Seidel(i) ] = solve_Gauss_Seidel(N(i));
end

plot_problem_5(N, time_Jacobi, time_Gauss_Seidel, iterations_Jacobi, iterations_Gauss_Seidel);
end

function plot_problem_5(N,time_Jacobi,time_Gauss_Seidel,iterations_Jacobi,iterations_Gauss_Seidel)
% Opis wektorów stanowiących parametry wejściowe:
% N - rozmiary analizowanych macierzy
% time_Jacobi - czasy wyznaczenia rozwiązania metodą Jacobiego
% time_Gauss_Seidel - czasy wyznaczenia rozwiązania metodą Gaussa-Seidla
% iterations_Jacobi - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Jacobiego
% iterations_Gauss_Seidel - liczba iteracji wymagana do wyznaczenia rozwiązania metodą Gauss-Seidla

subplot(2,1,1);
plot(N, time_Jacobi, 'b', N, time_Gauss_Seidel, 'r');
title('Czas obliczeń w zależności od rozmiaru macierzy');
xlabel('Rozmiar macierzy');
ylabel('Czas [s]');
legend('Jacobi', 'Gauss-Seidel', 'Location', 'eastoutside');

subplot(2,1,2);
bar(N, [iterations_Jacobi', iterations_Gauss_Seidel']);
title('Liczba iteracji w zależności od rozmiaru macierzy');
xlabel('Rozmiar macierzy');
ylabel('Liczba iteracji');
legend('Jacobi', 'Gauss-Seidel', 'Location', 'eastoutside');
print -dpng zadanie5.png;
end

function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(N)
% A - macierz rzadka z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% M - macierz pomocnicza opisana w instrukcji do Laboratorium 3 – sprawdź wzór (7) w instrukcji, który definiuje M jako M_{GS}
% bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3 – sprawdź wzór (7) w instrukcji, który definiuje bm jako b_{mGS}
% x - rozwiązanie równania macierzowego
% err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b)
% time - czas wyznaczenia rozwiązania x
% iterations - liczba iteracji wykonana w procesie iteracyjnym metody Gaussa-Seidla
% index_number - Twój numer indeksu
index_number = 201267 ;
L1 = mod(index_number,10);
[A,b] = generate_matrix(N, L1);

x = ones(N, 1);

D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);
M = -(D+L)\U;
bm = (D+L)\b;

tic;
max_iterations = 1000;
tolerance = 1e-12; 
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

index_number = 201267; 
L1 = mod(index_number, 10);
[A,b] = generate_matrix(N, L1);

x = ones(N, 1);
D = diag(diag(A));
L = tril(A, -1);
U = triu(A, 1);
M = -D \ (L + U);
bm = D \ b;


tic;
max_iterations = 1000;
tolerance = 1e-12; 
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
