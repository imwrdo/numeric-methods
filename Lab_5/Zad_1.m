function Zad_1
[V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1();
end

function [V, original_Runge, original_sine, interpolated_Runge, interpolated_sine] = zadanie1()
    N = 4:4:16;
    x_fine = linspace(-1, 1, 1000);
    original_Runge = runge_function(x_fine);

    subplot(2,1,1);
    plot(x_fine, original_Runge, 'DisplayName', 'Funkcja Runge');
    hold on;
    for i = 1:length(N)
        V{i} = vandermonde_matrix(N(i)); % Macierz Vandermonde
        x_interp = linspace(-1, 1, N(i)); % Węzły interpolacji
        y_interp_Runge = runge_function(x_interp); % Wartości funkcji Runge w węzłach interpolacji
        c_runge = V{i}\y_interp_Runge'; % Współczynniki wielomianu interpolującego
        interpolated_Runge{i} = polyval(flipud(c_runge), x_fine); % Interpolacja
        plot(x_fine, interpolated_Runge{i}, 'DisplayName', sprintf('N = %d', N(i)));
    end
    hold off;
    title('Interpolacja funkcji Runge');
    xlabel('x'); 
    ylabel('y'); 
    legend('show'); 

    original_sine = sin(2 * pi * x_fine);
    subplot(2,1,2);
    plot(x_fine, original_sine, 'DisplayName', 'Funkcja sinus');
    hold on;
    for i = 1:length(N)
        x_interp = linspace(-1, 1, N(i)); 
        y_interp_sine = sin(2 * pi * x_interp); 
        c_sine = V{i}\y_interp_sine'; 
        interpolated_sine{i} = polyval(flipud(c_sine), x_fine); 
        plot(x_fine, interpolated_sine{i}, 'DisplayName', sprintf('N = %d', N(i)));
    end
    hold off;
    title('Interpolacja funkcji sinus');
    xlabel('x');
    ylabel('y'); 
    legend('show'); 

    saveas(gcf, 'zadanie1.png');
end

function V = vandermonde_matrix(N)
    x = linspace(-1, 1, N);
    V = zeros(N);

    for i = 1:N
        V(:,i) = x.^(i-1);
    end
end

function y = runge_function(x)
    y = 1 ./ (1 + 25 * x.^2);
end
