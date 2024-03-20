function Zad_2
    N = 1000:1000:8000;
    n = length(N);
    vtime_direct = ones(1,n); 
    for i = 1:n
        [~, ~, ~, time_direct, ~, ~] = solve_direct(N(i));
        vtime_direct(i) = time_direct;
    end
    plot_direct(N, vtime_direct);
end

function plot_direct(N, vtime_direct)
    % N - wektor zawierający rozmiary macierzy dla których zmierzono czas obliczeń metody bezpośredniej
    % vtime_direct - czas obliczeń metody bezpośredniej dla kolejnych wartości N
    figure;
    plot(N, vtime_direct, '-o', 'LineWidth', 2);
    title('Czas wyznaczania rozwiązania równania macierzowego metodą bezpośrednią');
    xlabel('Rozmiar macierzy N');
    ylabel('Czas [s]');
    grid on;
    print -dpng zadanie2.png;
end

function [A,b,x,time_direct,err_norm,index_number] = solve_direct(N)
% A - macierz z równania macierzowego A * x = b
% b - wektor prawej strony równania macierzowego A * x = b
% x - rozwiązanie równania macierzowego
% time_direct - czas wyznaczenia rozwiązania x
% err_norm - norma błędu rezydualnego rozwiązania x; err_norm = norm(A*x-b);
% index_number - Twój numer indeksu
index_number = 201267;
L1 = mod(index_number,10);
[A,b] = generate_matrix(N, L1);

tic;
x = A\b;
time_direct = toc;
err_norm = norm(A*x-b);
end

function [A,b] = generate_matrix(N, convergence_factor)
    % A - macierz o rozmiarze NxN
    % b - wektor o rozmiarze Nx1
    % convergense_factor - regulacja elementów diagonalnych macierzy A, które wpływają
    %       na zbieżność algorytmów iteracyjnego rozwiązywania równania macierzowego

    if(convergence_factor<0 || convergence_factor>9)
        error('Wartość convergence_factor powinna być zawarta w przedziale [1,9]');
    end

    seed = 0; % seed - kontrola losowości elementów niezerowych macierzy A
    rng(seed); % ustawienie generatora liczb losowych

    A = rand(N, N);
    A = A - diag(diag(A)); % wyzerowanie głównej diagonalnej

    convergence_factor_2 = 1.2 + convergence_factor/10;
    diag_values = sum(abs(A),2) * convergence_factor_2;
    A = A + diag(diag_values); % nadanie nowych wartości na głównej diagonalnej

    % regulacja normy macierzy
    norm_Frobenius = norm(A,'fro');
    A = A/norm_Frobenius;

    b = rand(N,1);
end