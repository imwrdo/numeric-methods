function Zad_2
[nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2();
end

function [nodes_Chebyshev, V, V2, original_Runge, interpolated_Runge, interpolated_Runge_Chebyshev] = zadanie2()
    % nodes_Chebyshev - wektor wierszowy zawierający N=16 węzłów Czebyszewa drugiego rodzaju
% V - macierz Vandermonde obliczona dla 16 węzłów interpolacji rozmieszczonych równomiernie w przedziale [-1,1]
% V2 - macierz Vandermonde obliczona dla węzłów interpolacji zdefiniowanych w wektorze nodes_Chebyshev
% original_Runge - wektor wierszowy zawierający wartości funkcji Runge dla wektora x_fine=linspace(-1, 1, 1000)
% interpolated_Runge - wektor wierszowy wartości funkcji interpolującej określonej dla równomiernie rozmieszczonych węzłów interpolacji
% interpolated_Runge_Chebyshev - wektor wierszowy wartości funkcji interpolującej wyznaczonej
%       przy zastosowaniu 16 węzłów Czebyszewa zawartych w nodes_Chebyshev 
    N = 16;
    x_fine = linspace(-1, 1, 1000);
    nodes_Chebyshev = get_Chebyshev_nodes(N);

    V = vandermonde_matrix(N, linspace(-1, 1, N));
    V2 = vandermonde_matrix(N, nodes_Chebyshev);
    original_Runge = runge_function(x_fine);

    % Interpolacja dla równomiernie rozmieszczonych węzłów interpolacji
    x_interp = linspace(-1, 1, N);
    y_interp_Runge = runge_function(x_interp);
    c_runge = V\y_interp_Runge'; % Współczynniki wielomianu interpolującego
    interpolated_Runge = polyval(flipud(c_runge), x_fine); % Interpolacja

    % Interpolacja dla węzłów Czebyszewa drugiego rodzaju
    y_interp_Runge_Chebyshev = runge_function(nodes_Chebyshev);
    c_runge_Chebyshev = V2\y_interp_Runge_Chebyshev'; % Współczynniki wielomianu interpolującego
    interpolated_Runge_Chebyshev = polyval(flipud(c_runge_Chebyshev), x_fine); % Interpolacja

    % Wykresy
    subplot(2,1,1);
    plot(x_fine, original_Runge, 'DisplayName', 'Funkcja Runge');
    hold on;
    plot(x_fine, interpolated_Runge, 'DisplayName', 'Interpolacja równomierna');
    plot(x_interp, y_interp_Runge, 'o', 'DisplayName', 'Węzły interpolacji');
    hold off;
    title('Interpolacja dla równomiernych węzłów interpolacji');
    xlabel('x');
    ylabel('y');
    legend('show');

    subplot(2,1,2);
    plot(x_fine, original_Runge, 'DisplayName', 'Funkcja Runge');
    hold on;
    plot(x_fine, interpolated_Runge_Chebyshev, 'DisplayName', 'Interpolacja Czebyszewa');
    plot(nodes_Chebyshev, y_interp_Runge_Chebyshev, 'o', 'DisplayName', 'Węzły interpolacji');
    hold off;
    title('Interpolacja dla węzłów Czebyszewa drugiego rodzaju');
    xlabel('x');
    ylabel('y');
    legend('show');

    % Zapisz wykresy do pliku zadanie2.png
    saveas(gcf, 'zadanie2.png');
end

function nodes = get_Chebyshev_nodes(N)
    nodes = cos((pi*(0:N-1))/ (N-1));    
end

function V = vandermonde_matrix(N,nodes)
    % Tworzenie równomiernie rozmieszczonych węzłów interpolacji w przedziale [-1, 1]
    
    V = zeros(N);
    
    for i = 1:N
        V(:,i) = nodes.^(i-1);
    end
end

function y = runge_function(x)
    y = 1 ./ (1 + 25 * x.^2);
end
